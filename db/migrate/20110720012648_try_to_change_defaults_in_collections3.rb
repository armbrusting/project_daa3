class TryToChangeDefaultsInCollections3 < ActiveRecord::Migration
  def self.up
        change_column_default :collections, :pp_approval, 'no'
        change_column_default :collections, :top_approval, 'no'
        change_column_default :collections, :color_approval, 'no'
        change_column_default :collections, :print_approval, 'no'
        change_column_default :collections, :quality_approval, 'no'
        change_column_default :collections, :fit_approval, 'no'
      end
    end