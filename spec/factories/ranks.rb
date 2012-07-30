# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    universe
    level { universe.ranks.count + 1 }
    name { "Hero #{level}"}
    description { "You have #{3 * level.to_i} heroic acts!" }
  end
end
