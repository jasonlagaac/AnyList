class Item < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :event

  validates :name, :presence => true,
                   :length => {:maximum => 100}

  validates :description, :presence => true,
                          :length => {:maximum => 240}

  validates :event_id, :presence => true
  
  default_scope :order => 'items.created_at DESC'
end
