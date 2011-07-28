class TryToChangeDefaultsInCollections < ActiveRecord::Migration
  def self.up
    change_column :collections, :pp_approval, :string, :default => 'no'
    change_column :collections, :top_approval, :string, :default => 'no'
    change_column :collections, :color_approval, :string, :default => 'no'
    change_column :collections, :print_approval, :string, :default => 'no'
    change_column :collections, :quality_approval, :string, :default => 'no'
    change_column :collections, :fit_approval, :string, :default => 'no'
  end
end
