# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
    name 'For Fun'
    description 'Here you can post all your jokes and memes!'

    factory :forum_with_topics do
      ignore do
        topics_count 3
      end

      after :create do |forum, evaluator|
        FactoryGirl.create_list :topic, evaluator.topics_count, forum: forum
      end
    end
  end
end
