class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :firstname, :lastname, :username, 
                  :email, :password, :password_confirmation
  
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :firstname, :presence => true,
                        :length => { :maximum => 30 }
  
  validates :lastname, :presence => true,
                       :length => { :maximum => 30 }
  
  validates :username, :presence => true,
                       :length => { :maximum => 30 },
                       :uniqueness => true
                       
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    # Compare the encrypyed_password with the encrypted 
    # version of sumbitted_pasword located on the database
    self.encrypted_password == encrypt(submitted_password)
  end 
  
  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end 
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password =  encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}--#{username}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
               
end