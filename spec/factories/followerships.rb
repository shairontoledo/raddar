# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :followership do
    user
    followable factory: :stuff
  end
end
