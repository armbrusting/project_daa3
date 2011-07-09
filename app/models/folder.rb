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
  has_many :collections,  :foreign_key => "collector_id",
                          :dependent => :destroy
  has_many :collecting, :through => :collections, :source => :collected
  
  validates :name,    :presence => true, 
                      :length => { :maximum => 140 },
                      :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true
  
  default_scope :order => 'folders.name ASC'
  
  def collecting?(collected)
    collections.find_by_collected_id(collected)
  end

  def collect!(collected)
    collections.create!(:collected_id => collected.id)
  end
  
  def uncollect!(collected)
    collections.find_by_collected_id(collected).destroy
  end
end
