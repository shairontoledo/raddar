# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    universe
    sequence :level
    name { "Hero #{level}"}
    description { "You have #{3 * level.to_i} heroic acts!" }
  end
end
