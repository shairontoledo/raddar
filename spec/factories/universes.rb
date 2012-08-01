# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :universe do
    name 'Cosmic Horror'
    description 'In this section you will find a whole bunch of horror tales!'

    factory :universe_with_ranks do
      ignore { ranks_count 3 }

      after :create do |universe, evaluator|
        FactoryGirl.create_list :rank, evaluator.ranks_count, universe: universe
      end
    end
  end
end
