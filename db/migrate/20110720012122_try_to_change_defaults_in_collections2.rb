class TryToChangeDefaultsInCollections2 < ActiveRecord::Migration
  def self.up
      change_column_default :collections, :pp_approval, :default => 'no'
      change_column_default :collections, :top_approval, :default => 'no'
      change_column_default :collections, :color_approval, :default => 'no'
      change_column_default :collections, :print_approval, :default => 'no'
      change_column_default :collections, :quality_approval, :default => 'no'
      change_column_default :collections, :fit_approval, :default => 'no'
    end
  end