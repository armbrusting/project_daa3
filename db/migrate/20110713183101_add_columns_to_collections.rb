class AddColumnsToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :notes, :string
    add_column :collections, :projected_units, :integer
    add_column :collections, :number_of_colors, :integer
    add_column :collections, :size, :string
    add_column :collections, :modification, :string
    add_column :collections, :delivery_date, :date
    add_column :collections, :export, :string
    add_column :collections, :shipment, :string
    add_column :collections, :ship_cost, :integer
    add_column :collections, :pricing, :integer
  end

  def self.down
    remove_column :collections, :pricing
    remove_column :collections, :ship_cost
    remove_column :collections, :shipment
    remove_column :collections, :export
    remove_column :collections, :delivery_date
    remove_column :collections, :modification
    remove_column :collections, :size
    remove_column :collections, :number_of_colors
    remove_column :collections, :projected_units
    remove_column :collections, :notes
  end
end
