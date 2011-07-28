class AddApprovalsToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :fit_approval, :boolean, :default => false
    add_column :collections, :fit_approval_date, :datetime
    add_column :collections, :fit_approval_note, :string
    add_column :collections, :color_approval, :boolean, :default => false
    add_column :collections, :color_approval_date, :datetime
    add_column :collections, :color_approval_note, :string
    add_column :collections, :print_approval, :boolean, :default => false
    add_column :collections, :print_approval_date, :datetime
    add_column :collections, :print_approval_note, :string
    add_column :collections, :quality_approval, :boolean, :default => false
    add_column :collections, :quality_approval_date, :datetime
    add_column :collections, :quality_approval_note, :string
    add_column :collections, :factory_start_date, :datetime
    add_column :collections, :ex_factory_date, :datetime
    add_column :collections, :pp_approval, :boolean, :default => false
    add_column :collections, :pp_approval_date, :datetime
    add_column :collections, :pp_approval_note, :string
    add_column :collections, :top_approval, :boolean, :default => false
    add_column :collections, :top_approval_date, :datetime
    add_column :collections, :top_approval_note, :string
    add_column :collections, :vessel, :string
    add_column :collections, :voyage, :string
    add_column :collections, :tacking_number, :string
    add_column :collections, :eta, :datetime
    add_column :collections, :status, :string, :default => 'new'
    add_index :collections, :status
  end

  def self.down
    remove_column :collections, :fit_approval
    remove_column :collections, :fit_approval_date
    remove_column :collections, :fit_approval_note
    remove_column :collections, :color_approval
    remove_column :collections, :color_approval_date
    remove_column :collections, :color_approval_note
    remove_column :collections, :print_approval
    remove_column :collections, :print_approval_date
    remove_column :collections, :print_approval_note
    remove_column :collections, :quality_approval
    remove_column :collections, :quality_approval_date
    remove_column :collections, :quality_approval_note
    remove_column :collections, :factory_start_date
    remove_column :collections, :ex_factory_date
    remove_column :collections, :pp_approval
    remove_column :collections, :pp_approval_date
    remove_column :collections, :pp_approval_note
    remove_column :collections, :top_approval
    remove_column :collections, :top_approval_date
    remove_column :collections, :top_approval_note
    remove_column :collections, :vessel
    remove_column :collections, :voyage
    remove_column :collections, :tacking_number
    remove_column :collections, :eta
    remove_column :collections, :status
  end
end
