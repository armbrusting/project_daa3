class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.integer :collector_id
      t.integer :collected_id

      t.timestamps
    end
    add_index :collections, :collector_id
    add_index :collections, :collected_id
  end

  def self.down
    drop_table :collections
  end
end
