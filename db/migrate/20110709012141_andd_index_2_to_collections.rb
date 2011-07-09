class AnddIndex2ToCollections < ActiveRecord::Migration
  def self.up
    add_index :collections, [:collector_id, :collected_id], :unique => false
  end
end
