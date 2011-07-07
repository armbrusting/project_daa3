# By using the symbol ':user', we get Factory Girl to simulate the User model.
include ActionDispatch::TestProcess
 
class User
  attr_accessor :avatar_file_name
  attr_accessor :avatar_file_size
  has_attached_file :avatar, :styles => { :medium => "300x300>", 
                                          :small => "100x100>",
                                          :thumb => "30x30>" },
            :url  => "/public/images/ryan.jpg",
            :path => ":rails_root/public/images/:filename"
end

Factory.define :user do |u|
  u.name                  "Michael Hartl"
  u.email                 "mhartl@example.com"
  u.password              "foobar"
  u.password_confirmation "foobar"
  u.avatar   { fixture_file_upload( 'public/images/ryan.jpg', 'image/jpeg') }
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end