# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


seed_file = File.join(Rails.root, 'db', 'organizations.yml')
config = YAML::load_file(seed_file)
Organization.transaction do
  config.keys.each{ |key| key.classify.constantize.create(config[key]) }
end

seed_file = File.join(Rails.root, 'db', 'subjects.yml')
config = YAML::load_file(seed_file)
Subject.transaction do
  config.keys.each{ |key| key.classify.constantize.create(config[key]) }
end

seed_file = File.join(Rails.root, 'db', 'categories.yml')
config = YAML::load_file(seed_file)
Category.transaction do
  config.keys.each{ |key| key.classify.constantize.create(config[key]) }
end
=begin
seed_file = File.join(Rails.root, 'db', 'address.yml')
config = YAML::load_file(seed_file)
Address.transaction do
  config.keys.each{ |key| key.classify.constantize.create(config[key]) }
end


seed_file = File.join(Rails.root, 'db', 'org.yml')
config = YAML::load_file(seed_file)
Organization.create(config["organizations"])
seed_file = File.join(Rails.root, 'db', 'seed.yml')
config = YAML::load_file(seed_file)
Address.create(config["addresses"], :organization => )

each {|k, v| Address.create!{:from => k, :organization_i
config["addresses"].first.to_a[1][1]
=end
user = User.create! do |u|
      u.email = 'user@test.com'
      u.password = 'user123'
      u.password_confirmation = 'user123'
      #u.ensure_authentication_token!
      u.trained = false
    end



seed_file = File.join(Rails.root, 'db', 'address.yml')
config = YAML::load_file(seed_file)
arr = config.flatten
arr.shift
arr.flatten.each do |conf|
    Address.create!(:from => conf.to_a[0][1], :organization_id => Organization.find_or_create_by_title(conf.to_a[1][1]).id)
end

seed_file = File.join(Rails.root, 'db', 'messages_train.yml')
config = YAML::load_file(seed_file)
arr = config.flatten
arr.shift
arr.flatten.each do |conf|
    Message.create!(:body => conf.to_a[0][1], :train => conf.to_a[1][1], :address_id => Address.find_or_create_by_from(conf.to_a[2][1]).id, :category_id => Category.find_or_create_by_title(conf.to_a[3][1]).id, :subject_id => Subject.find_or_create_by_title(conf.to_a[4][1]).id, :assigned_category => 'unknown', :user_id => User.first.id)
end

a = Message.all(:conditions => "address_id IS NULL")
a.each do |mes|
  mes.update_attribute(:address_id, Address.find_or_create_by_from('unknown').id)
end

seed_file = File.join(Rails.root, 'db', 'messages_test.yml')
config = YAML::load_file(seed_file)
i = 0
arr = config.flatten
arr.shift
arr.flatten.each do |conf|
    Message.create!(:body => conf.to_a[0][1], :train => conf.to_a[1][1], :address_id => Address.find_or_create_by_from(conf.to_a[2][1]).id, :category_id => Category.find_or_create_by_title(conf.to_a[3][1]).id, :subject_id => Subject.find_or_create_by_title(conf.to_a[4][1]).id, :assigned_category => 'unknown', :user_id => User.first.id)
    i = i +1
end

a = Message.find(:all, :conditions => {:address_id => nil})
a.each do |mes|
  mes.update_attribute(:address_id, Address.find_or_create_by_from('unknown').id)
end
a = Message.all(:conditions => "address_id IS NULL")
a.each do |mes|
  mes.update_attribute(:address_id, Address.find_or_create_by_from('unknown').id)
end
User.first.training


m = Message.find_in_batches(:conditions => {:train => false, :assigned_category => 'unknown'}, :batch_size => 10) do |mess|
sleep(35)
  mess.each {|mes| mes.classify}
end

