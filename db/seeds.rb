# -*- encoding : utf-8 -*-

u = User.new
u.name = 'volmer'
u.email = 'volmer@volmer.com'
u.password = '123456'
u.gender = :male
u.date_of_birth = 30.years.ago.to_date
u.bio = "Lover\nRocker\nKiller"
u.facebook_access_token = 'ACCESS_TOKEN'
u.facebook_url = 'http://facebook.com/'
u.location = 'Brasília-DF'
u.confirm!
u.save!

r = Role.new
r.name = :admin
r.save!

u.roles << r