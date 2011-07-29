class AddIndexToCompanies < ActiveRecord::Migration
  def self.up
      remove_index :companies, :name
  end
end
