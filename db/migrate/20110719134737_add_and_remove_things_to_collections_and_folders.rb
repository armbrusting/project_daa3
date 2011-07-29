class AddAndRemoveThingsToCollectionsAndFolders < ActiveRecord::Migration
  def self.up
    remove_column :collections, :attention
    drop_table :notices
    remove_column :folders, :attention
    remove_column :folders, :attn_monopol
    remove_column :folders, :attn_daa
    change_column :collections, :pricing, :decimal, :precision => 8, :scale => 2
    change_column :collections,  :ship_cost, :decimal, :precision => 8, :scale => 2
    add_column :styles, :fabric, :string 
  end

  def self.down
		remove_column :styles, :fabric
  end
end
