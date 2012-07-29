# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user
    content 'Joey is now following you!'
    item_path '/path/to/joey'
  end
end
