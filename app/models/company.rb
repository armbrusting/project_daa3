# == Schema Information
#
# Table name: companies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
  attr_accessible :name, :contact, :notes
  
  belongs_to :user
  
  has_many :folders
  
  validates :name,    :presence => true, 
                      :length => { :maximum => 140 },
                      :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true
  
  default_scope :order => 'companies.name ASC'
end
