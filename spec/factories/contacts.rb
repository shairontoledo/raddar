# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name 'user'
    email 'user@example.net'
    message 'a beautiful text'
  end
end
