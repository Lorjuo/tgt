# rake db:seed

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Create generic users:"
puts "user: user | admin: admin"
FactoryGirl.create(:admin, first_name: "admin", last_name: "generic", email: "admin@tgtraisa.de")
FactoryGirl.create(:user, first_name: "user", last_name: "generic", email: "user@tgtraisa.de")

puts "Create generic department"
generic_department = Department.create(:name => "generic")
#Department.create({:name => "generic", :id => 0}, :without_protection => true)
# department = Department.new(:name => "generic", :id => 0)
# department.id = 0
# department.save(validate: false)

# department = Department.first
# department.id = 0
# department.save!
# # Reset autoincrement counter
# ActiveRecord::Base.connection.execute("ALTER TABLE departments AUTO_INCREMENT = 1")

NavigationElement.create(:name => 'Sport', :parent_id => nil, :controller_id => nil, :action_id => nil, :instance_id => nil, :department_id => generic_department.id)
NavigationElement.create(:name => 'Kultur', :parent_id => nil, :controller_id => nil, :action_id => nil, :instance_id => nil, :department_id => generic_department.id)

dir = File.join(Rails.public_path, 'files')+"/announcements"
unless File.directory?(dir)
  FileUtils.mkdir_p(dir)
end
