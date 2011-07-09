class AddIndexToCollections < ActiveRecord::Migration
  def self.up
    add_index :collections, [:collector_id, :collected_id], :unique => true
  end
end
