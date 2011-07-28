class ChangeColumnTypesInCollections3 < ActiveRecord::Migration
  def self.up
        change_column :collections, :pp_approval, :string, :default => "no"
        change_column :collections, :top_approval, :string, :default => "no"
      end
    end
