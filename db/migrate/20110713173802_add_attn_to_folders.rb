class AddAttnToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :attention, :string
    add_index :folders, :attention
  end

  def self.down
    remove_column :folders, :attention
  end
end
