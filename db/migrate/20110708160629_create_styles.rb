class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.integer :number
      t.integer :user_id

      t.timestamps
    end
    add_index :styles, :number
  end

  def self.down
    drop_table :styles
  end
end
