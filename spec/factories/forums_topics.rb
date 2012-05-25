# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forums_topic, :class => 'Forums::Topic' do
    title "MyString"
    views 1
  end
end
