class AddIndexToCompanies < ActiveRecord::Migration
  def self.up
      add_index :companies, :name
  end
end
