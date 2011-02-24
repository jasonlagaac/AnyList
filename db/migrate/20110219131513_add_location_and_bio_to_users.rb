class AddLocationAndBioToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bio, :string
    add_column :users, :location, :string
  end

  def self.down
    remove_column :users, :location
    remove_column :users, :bio
  end
end
