class Event < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :user
  has_many :items, :dependent => :destroy
  
  validates :title, :presence => true, :length => { :maximum => 120 }
  validates :user_id, :presence => true
  
  default_scope :order => 'events.created_at DESC'
end
