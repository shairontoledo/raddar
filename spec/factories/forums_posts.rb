# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forums_post, :class => 'Forums::Post' do
    content "MyString"
  end
end
