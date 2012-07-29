# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content 'Hi, sweetheart!'
    sender factory: :user
    recipient factory: :user
  end
end
