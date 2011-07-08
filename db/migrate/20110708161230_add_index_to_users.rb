class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :name
  end

end
