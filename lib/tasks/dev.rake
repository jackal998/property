namespace :dev do

  task :rebuild => ["db:reset", :fake]

  task :fake => :environment do 
    # User.delete_all
    # Obj.delete_all
    # Comment.delete_all

    puts "Creating"

    # user = User.create!(:email=>"zxc@zxc",:password => "zxczxc",:role=>"admin")

    (1..15).to_a.sample.times do |i|
      u = User.create(:email => "#{i&i&i}@faker",:password => "123123")
    end

    created_users = User.count
    @users = User.all

    (1..25).to_a.sample.times do |j|

      randuser_id = (1..created_users).to_a.sample
      @user = @users.find(randuser_id)

      serialnumber = Faker::StarWars.droid + "#{j}"
      sn2 = Faker::Code.imei if [true,false].sample

      o = Obj.create(
        :name=>Faker::Space.star,
        :serial=>serialnumber, 
        :datebought=>Faker::Date.between(1.year.ago, 2.days.ago), 
        :dateretire=>Faker::Date.between(Date.today,5.years.from_now), 
        :value =>Faker::Number.between(100000, 1000000), 
        :snumber1=>Faker::Code.asin, 
        :snumber2=>sn2,
        :description=>Faker::Lorem.paragraph(1,true,4),
        :custodian=>Faker::Name.name,
        :user=> @user)

      (1..10).to_a.sample.times do |k|
        @user = @users.find((1..created_users).to_a.sample)
        Comment.create(
          :title => Faker::Company.name, 
          :paragraph => Faker::Lorem.paragraph(1, true, 2),
          :obj => o,
          :user => @user)
      end

    end
  end
end