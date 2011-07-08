class AddIndexToFolders < ActiveRecord::Migration
  def self.up
    add_index :folders, :name
  end
end
