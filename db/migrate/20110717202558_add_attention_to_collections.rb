class AddAttentionToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :attention, :string
    add_index :collections, :attention
  end

  def self.down
    remove_column :collections, :attention
  end
end