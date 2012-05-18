# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.name = 'volmer'
u.email = 'volmer@volmer.com'
u.email_privacy = :public
u.password = '123456'
u.gender = :male
u.gender_privacy = :public
u.date_of_birth = 30.years.ago.to_date
u.date_of_birth_privacy = :public
u.bio = "Lover\nRocker\nKiller"
u.facebook_access_token = 'ACCESS_TOKEN'
u.facebook_url = 'http://facebook.com/'
u.facebook_url_privacy = :public
u.confirm!
u.save!

r = Role.new
r.name = :admin
r.save!

u.roles << r