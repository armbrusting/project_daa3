class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.string :attention
      t.integer :folder_id

      t.timestamps
    end
    add_index :notices, :attention
  end

  def self.down
    drop_table :notices
  end
end
