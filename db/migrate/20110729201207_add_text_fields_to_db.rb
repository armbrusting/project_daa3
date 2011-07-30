class AddTextFieldsToDb < ActiveRecord::Migration
  def self.up
    add_column :companies, :contact, :string
    add_column :companies, :notes, :text
    change_column :styles, :description, :text
    change_column :collections, :notes, :text
    change_column :collections, :fit_approval_note, :text
    change_column :collections, :color_approval_note, :text
    change_column :collections, :print_approval_note, :text
    change_column :collections, :quality_approval_note, :text
    change_column :collections, :pp_approval_note, :text
    change_column :collections, :top_approval_note, :text
  end

  def self.down
    remove_column :companies, :contact
    remove_column :companies, :notes  
  end
end
