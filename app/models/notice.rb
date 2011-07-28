class Notice < ActiveRecord::Base
  attr_accessible :attention, :folder_id
  
  belongs_to :folder, :foreign_key => "folder_id"
  
  validates :folder_id, :presence => true
end
