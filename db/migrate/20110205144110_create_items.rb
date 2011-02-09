class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :description
      t.string :name
      t.integer :event_id

      t.timestamps
    end
    add_index :items, :event_id
  end

  def self.down
    drop_table :items
  end
end
