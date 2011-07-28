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
  attr_accessible :name, :company_id, :attn_monopol, :attn_daa, :attention
  
  belongs_to :user
  #belongs_to :company, :dependent => :destroy
  
  has_many :collections,  :foreign_key => "collector_id",
                          :dependent => :destroy
  has_many :collecting, :through => :collections, :source => :collected
  
  has_one :notice,    :dependent => :destroy
  
  belongs_to :company,   :foreign_key => "company_id",
                         :dependent => :destroy
  
  validates :name,    :presence => true, 
                      :length => { :maximum => 140 },
                      :uniqueness => {:scope => :company_id, 
                                      :case_sensitive => false }
  validates :user_id, :presence => true
  
  #validates :company_id, :presence => true
  
  default_scope :order => 'folders.name ASC'
  
  scope :attn_monopol, where(:attention => "monopol")
  scope :attn_daa, where(:attention => "daa")
  
  def collecting?(collected)
    collections.find_by_collected_id(collected)
  end

  def collect!(collected)
    collections.create!(:collected_id => collected.id)
  end
  
  def uncollect!(collected)
    collections.find_by_collected_id(collected).destroy
  end
  
  def linesheet
    Collection.collected_by(self)
  end
end
