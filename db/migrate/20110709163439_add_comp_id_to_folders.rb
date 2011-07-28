class AddCompIdToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :company_id, :integer
    add_index :folders, :company_id
  end

  def self.down
    remove_column :folders, :company_id
  end
end
