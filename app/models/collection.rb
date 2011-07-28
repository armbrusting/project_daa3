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
    attr_accessible :collected_id, :collector_id, :pricing, :ship_cost, 
                    :shipment, :export,
                    :delivery_date, :modification, :size, :number_of_colors,
                    :projected_units, :notes, :attention, :fit_approval, 
                    :fit_approval_date, :fit_approval_note, :color_approval, 
                    :color_approval_date, :color_approval_note, 
                    :print_approval, :print_approval_date, 
                    :print_approval_note, :quality_approval, 
                    :quality_approval_date, :quality_approval_note, 
                    :factory_start_date, :ex_factory_date, :pp_approval, 
                    :pp_approval_date, :pp_approval_note, :top_approval, 
                    :top_approval_date, :top_approval_note, :vessel, 
                    :voyage, :tacking_number, :eta, :status
    
    belongs_to :collector, :class_name => "Folder"
    belongs_to :collected, :class_name => "Style"
    
    money_column :pricing 
    money_column :ship_cost
    
    validates :collector_id, :presence => true
    validates :collected_id, :presence => true
 private   
    def self.collected_by(folder)
      collecting_ids = %(SELECT id FROM collections
                              WHERE collector_id = :folder_id)
      where("id IN (#{collecting_ids})", { :folder_id => folder })
    end
end
