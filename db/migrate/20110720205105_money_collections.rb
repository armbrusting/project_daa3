class MoneyCollections < ActiveRecord::Migration
  def self.up
    change_column :collections,  :ship_cost, :decimal, :precision => 8, :scale => 2, :default => 0.0
    
  end

  def self.down
  end
end
