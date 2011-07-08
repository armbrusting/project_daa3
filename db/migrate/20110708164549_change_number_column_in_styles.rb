class ChangeNumberColumnInStyles < ActiveRecord::Migration
  def self.up
    change_column(:styles, :number, :string)
  end
end
