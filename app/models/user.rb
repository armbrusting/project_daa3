# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  encrypted_password  :string(255)
#  salt                :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  admin               :boolean         default(FALSE)
#

class User < ActiveRecord::Base
    attr_accessor :password
    attr_accessible :name, :email, :password, :password_confirmation, :avatar, 
                    :avatar_file_name, :avatar_content_type, 
                    :avatar_file_size, :avatar_updated_at
                    
    has_many :companies
    has_many :folders
    has_many :styles
  
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, :presence => true,
                    :length   => { :maximum => 50 }
    validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
    
    # Automatically create the virtual attribute 'password_confirmation'.
    validates :password, :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
    
    #Paperclip
    has_attached_file :avatar, :styles => { 
                             :medium => "300x300>", 
                             :small => "100x100>",
                             :thumb => "30x30>" }
                             
    validates_attachment_size :avatar, :less_than => 5.megabytes
    validates_attachment_content_type :avatar, 
                                :content_type => ['image/jpeg', 'image/png'] 
                                                    
    before_save :encrypt_password
    
    # Return true if the user's password matches the submitted password.
    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end
    
    def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      user && user.has_password?(submitted_password) ? user : nil
    end
    
    def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
    
    private
    
      def encrypt_password
          self.salt = make_salt if new_record?
          self.encrypted_password = encrypt(password)
      end

      def encrypt(string)
        secure_hash("#{salt}--#{string}")
      end
      
      def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
      end

      def secure_hash(string)   
        Digest::SHA2.hexdigest(string)
      end
end
