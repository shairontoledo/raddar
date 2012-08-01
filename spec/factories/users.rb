# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user#{n}"
    end

    email { "#{name}@example.com" }

    date_of_birth { 13.years.ago.to_date }
    gender :female
    password '123456'

    before :create do |user|
      user.confirm!
    end

    factory :user_with_notifications do
      ignore { notifications_count 3 }

      after :create do |user, evaluator|
        FactoryGirl.create_list :notification, evaluator.notifications_count, user: user
      end
    end
  end
end
