class AnddIndex2ToCollections < ActiveRecord::Migration
  def self.up
    remove_index :collections, [:collector_id, :collected_id]
    add_index :collections, [:collector_id, :collected_id], :unique => false
  end
end
