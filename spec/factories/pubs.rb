# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pub do
    user
    name 'Dagon'
    description 'A nice horror story'
  end
end
