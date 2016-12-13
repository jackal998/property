namespace :schedule_public do
  task :set_publish => :environment do
    @to_be_publics = Obj.where('ispublic = ? and schedule_public < ?', true, Time.now + 3600 * 8).where().not(schedule_public: '1900-01-01 00:00:00')
    @to_be_publics.each {|o| o.update(schedule_public: '1900-01-01 00:00:00')}
    puts "#{Time.now}" + ", scheduled to be public with obj.ids are : " + "#{@to_be_publics.ids}"
    @to_be_publics = ''
  end
end