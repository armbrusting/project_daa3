class ChangeColumnTypesInCollections < ActiveRecord::Migration
  def self.up
    change_column :collections, :factory_start_date, :date
    change_column :collections, :ex_factory_date, :date
    change_column :collections, :eta, :date
  end
end
