# == Schema Information
#
# Table name: styles
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Style < ActiveRecord::Base
  attr_accessible :number, :photo, :description, :department, :classification,
                  :season, :printed, :embellished, :moq,
                  :photo_file_name, :photo_content_type, 
                  :photo_file_size, :photo_updated_at
  
  belongs_to :user
  
  number_regex = /\A[D][A][-]\d\d\d\d\d\d\z/i
  
  validates :number,  :presence => true, 
                      :format   => { :with => number_regex },
                      :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true
  
  #Paperclip
  has_attached_file :photo, :styles => { 
                           :large => "600x600",
                           :medium => "300x300>", 
                           :small => "100x100>",
                           :thumb => "30x30>" }
                           
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, 
                              :content_type => ['image/jpeg', 'image/png']
  
  default_scope :order => 'styles.number ASC'
end
