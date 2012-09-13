# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    user
    name 'Minas Tirith'
    coordinates [ -44.6430297, -13.3403685 ]
    description 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum
             cerebro. De carne lumbering animata corpora quaeritis. Summus
             brains sit, morbo vel maleficia? De apocalypsi gorger omero
             undead survivor dictum mauris. Hi mindless mortuis soulless 
             creaturas, imo evil stalking monstra adventus resi dentevil 
             vultus comedat cerebella viventium.'

    factory :venue_with_comments do
      ignore do
        comments_count { rand(1..5) }
      end

      after :create do |venue, evaluator|
        FactoryGirl.create_list :comment, evaluator.comments_count, commentable: venue, user: venue.user
      end
    end
  end
end
