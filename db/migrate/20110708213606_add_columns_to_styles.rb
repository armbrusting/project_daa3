class AddColumnsToStyles < ActiveRecord::Migration
  def self.up
    add_column :styles, :description, :string
    add_column :styles, :department, :string
    add_column :styles, :classification, :string
    add_column :styles, :season, :string
    add_column :styles, :printed, :boolean
    add_column :styles, :embellished, :boolean
    add_column :styles, :moq, :integer
    add_index :styles, :department
    add_index :styles, :classification
    add_index :styles, :season
    add_index :styles, :printed
    add_index :styles, :embellished
    add_index :styles, :moq
  end

  def self.down
    remove_column :styles, :moq
    remove_column :styles, :embellished
    remove_column :styles, :printed
    remove_column :styles, :season
    remove_column :styles, :classification
    remove_column :styles, :department
    remove_column :styles, :description
  end
end
