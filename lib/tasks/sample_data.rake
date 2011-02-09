namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    User.all(:limit => 6).each do |user|
      5.times do
        user.events.create!(:title => Faker::Lorem.sentence(1))
      end
      
      user.events.each do |event|
          event.items.create!(:name => Faker::Lorem.sentence(1), :description => Faker::Lorem.sentence(5))
      end
    end
  end
end