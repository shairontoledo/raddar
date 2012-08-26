admin = FactoryGirl.create :user, name: 'admin'

role = FactoryGirl.create :role, name: :admin

admin.roles << role

FactoryGirl.create_list :universe_with_ranks, 15

FactoryGirl.create_list :forum_with_random_topics, 3

FactoryGirl.create_list :pub_with_random_stuffs, 3

FactoryGirl.create_list :page, 11

FactoryGirl.create_list :venue_with_comments, 6

