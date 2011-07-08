# == Schema Information
#
# Table name: folders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Folder < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :user
  
  validates :name,    :presence => true, 
                      :length => { :maximum => 140 },
                      :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true
  
  default_scope :order => 'folders.name ASC'
end
