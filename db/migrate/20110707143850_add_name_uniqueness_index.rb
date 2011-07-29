class AddNameUniquenessIndex < ActiveRecord::Migration
  def self.up
    change_column :companies, :name, :unique => true
  end
end
