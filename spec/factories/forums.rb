# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
    name 'For Fun'
    description 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum 
                 cerebro. De carne lumbering animata corpora quaeritis.
                 Summus brains sit, morbo vel maleficia?'

    factory :forum_with_topics do
      ignore do
        topics_count { rand(3..20) }
      end

      after :create do |forum, evaluator|
        FactoryGirl.create_list :topic_with_posts, evaluator.topics_count, forum: forum
      end
    end
  end
end
