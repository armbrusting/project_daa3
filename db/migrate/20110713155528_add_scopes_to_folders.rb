class AddScopesToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :attn_monopol, :boolean
    add_column :folders, :attn_daa, :boolean
    add_index :folders, :attn_monopol
    add_index :folders, :attn_daa    
  end

  def self.down
    remove_column :folders, :attn_monopol
    remove_column :folders, :attn_daa
  end
end
