# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.name = 'volmer'
u.email = 'lrvolmer@gmail.com'
u.email_visibility = :public
u.password = '123456'
u.gender = :male
u.gender_visibility = :public
u.date_of_birth = 30.years.ago.to_date
u.date_of_birth_visibility = :public
u.bio = "Lover\nRocker\nKiller"
u.confirm!
u.save!