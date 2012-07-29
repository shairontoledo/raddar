# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :watching do
    user
    watchable factory: :pub
  end
end
