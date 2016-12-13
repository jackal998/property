namespace :dev do

  task :rebuild => ["db:reset", :fake]

  task :fake => :environment do 
    User.delete_all
    Obj.delete_all
    Comment.delete_all

    puts "Creating Users"

    user = User.create!(:email=>"zxc@zxc",:password => "zxczxc",:role=>"admin")

    (1..9).to_a.sample.times do |i|
      u = User.create(
        :email => "#{i&i&i}@faker",
        :password => "123123",
        :nickname => Faker::Superhero.name,
        )
    end

    @users = User.all

    puts "Creating Objs"

    (1..27).to_a.sample.times do |j|

      randuser_id = @users.ids.sample
      @user = @users.find(randuser_id)

      serialnumber = Faker::StarWars.droid + Faker::Code.asin
      sn2 = Faker::Code.imei if [true,false].sample

      o = Obj.create(
        :name=>Faker::Space.star,
        :serial=>serialnumber,
        :category_ids => (1..6).to_a.sample((1..6).to_a.sample),
        :datebought=>Faker::Date.between(1.year.ago, 2.days.ago), 
        :dateretire=>Faker::Date.between(Date.today,5.years.from_now), 
        :value =>Faker::Number.between(100000, 1000000), 
        :snumber1=>Faker::Code.asin, 
        :snumber2=>sn2,
        :description=>Faker::Lorem.paragraph(1,true,4),
        :custodian=>Faker::Name.name,
        :ispublic => [true,false].sample,
        :user=> @user)

      (1..3).to_a.sample.times do |k|
        @user = @users.find(@users.ids.sample)
        Comment.create(
          :title => Faker::Company.name, 
          :paragraph => Faker::Lorem.paragraph(1, true, 2),
          :obj => o,
          :user => @user)
      end
    end

    puts "Sucess!!"

  end
end