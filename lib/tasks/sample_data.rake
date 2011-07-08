namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@armbrust.com",
                 :password => "password", #was foobar but had to change it 
                 :password_confirmation => "password") 
    admin.toggle!(:admin)
                 
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@armbrust.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample);
      user.password = "password";
      user.password_confirmation = "password";
       user.save! }
       
    User.all(:limit => 3).each do |user|
      20.times do
        user.companies.create!(:name => Faker::Company.name)
      end
    end
    
    User.all(:limit => 3).each do |user|
      20.times do
        user.folders.create!(:name => Faker::Lorem.words(2))
      end
    end
  end
end