class AddAttachmentPhotoToStyle < ActiveRecord::Migration
  def self.up
    add_column :styles, :photo_file_name, :string
    add_column :styles, :photo_content_type, :string
    add_column :styles, :photo_file_size, :integer
    add_column :styles, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :styles, :photo_file_name
    remove_column :styles, :photo_content_type
    remove_column :styles, :photo_file_size
    remove_column :styles, :photo_updated_at
  end
end
