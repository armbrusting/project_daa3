# == Schema Information
#
# Table name: collections
#
#  id           :integer         not null, primary key
#  collector_id :integer
#  collected_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Collection < ActiveRecord::Base
    attr_accessible :collected_id
    
    belongs_to :collector, :class_name => "Folder"
    belongs_to :collected, :class_name => "Style"
    
    validates :collector_id, :presence => true
    validates :collected_id, :presence => true
end
