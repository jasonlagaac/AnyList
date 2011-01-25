require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :firstname => "George",
      :lastname => "Washington",
      :username => "atestuser", 
      :email => "atestuser@something.com",
      :password => "foobarbinbash",
      :password_confirmation => "foobarbinbash"
    }
  end
  
  it "should create a new User instance based on information entered" do
    User.create!(@attr)
  end
  
  it "should require a usename" do
    no_username = User.new(@attr.merge(:username=>""))
    no_username.should_not be_valid
  end
  
  it "should require an email" do
    no_email = User.new(@attr.merge(:email=>""))
    no_email.should_not be_valid
  end
  
  it "should reject a long username" do
    long_username = "a" * 51;
    long_username_user = User.new(@attr.merge(:username => long_username))
    long_username_user.should_not be_valid
  end
  
  it "should accept properly formatted emails" do
    emails = ["example@example.com", "example_example@example.com", "my.name@example.co.uk"]
    emails.each do |email|
      valid_email_user = User.new(@attr.merge(:email => email))
      valid_email_user.should be_valid
    end
  end 
  
  it "should reject ambiguously formatted emails" do
    emails = ["!Ex*mpl3@somemail.com", "jerk@email", "blahblah.com" ]
    emails.each do |email|
      invalid_email_user = User.new(@attr.merge(:email => email))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject duplicate email addresses with alternative case" do
   upcased_email = @attr[:email].upcase
   User.create!(@attr.merge(:email => upcased_email))
   user_with_dup_email = User.new(@attr)
   user_with_dup_email.should_not be_valid
  end
  
  it "should reject duplicate records" do
   User.create!(@attr)
   user_dup = User.new(@attr)
   user_dup.should_not be_valid
  end
  
  describe "password validation" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password confirmation" do 
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject long passwords" do
      User.new(@attr.merge(:password => 'a'*90, :password_confirmation => 'a'*90)).should_not be_valid
    end
  
    it "should reject short passwords" do
      User.new(@attr.merge(:password => 'a'*2, :password_confirmation => 'a'*2)).should_not be_valid
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should not have blank encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
    
    it "has_password? method" do
      @user.has_password?(@attr[:password]).should be_true
    end
    
    it "should be false if the passwords don't match" do
      @user.has_password?("invalid").should be_false
    end
    
    describe "password encryption" do
        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end
        
        it "should return nil for an username with no user" do
          nonexistent_user = User.authenticate("failure", @attr[:password])
          nonexistent_user.should be_nil
        end
        
        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:username],@attr[:password])
          matching_user.should == @user
        end
    end
    
  end
end
