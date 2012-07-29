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
  end
end
