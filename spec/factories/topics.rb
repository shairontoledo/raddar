# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    name 'Oh, my God! This is Polemic!'
    forum
    user

    factory :topic_with_posts do
      ignore do
        posts_count 3
      end

      after :create do |topic, evaluator|
        FactoryGirl.create_list :post, evaluator.posts_count, topic: topic, user: topic.user
      end
    end

    factory :topic_with_random_posts do
      ignore do
        posts_count { rand(1..20) }
      end

      after :create do |topic, evaluator|
        FactoryGirl.create_list :post, evaluator.posts_count, topic: topic, user: topic.user
      end
    end
  end
end
