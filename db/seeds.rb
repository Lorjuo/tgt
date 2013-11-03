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
FactoryGirl.create(:admin, first_name: "admin", last_name: "generic")
FactoryGirl.create(:user, first_name: "user", last_name: "generic")

puts "Create generic department"
Department.create({"name"=>"generic", "id"=>0})
