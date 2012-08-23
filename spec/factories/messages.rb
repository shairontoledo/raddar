# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum 
             cerebro. De carne lumbering animata corpora quaeritis.'
    sender factory: :user
    recipient factory: :user
  end
end
