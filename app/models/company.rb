class Company < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :user
  
  validates :name,    :presence => true, 
                      :length => { :maximum => 140 },
                      :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true
  
  default_scope :order => 'companies.name ASC'
end
