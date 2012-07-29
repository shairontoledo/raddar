# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user
    content 'Nice one!'
    commentable factory: :stuff
  end
end
