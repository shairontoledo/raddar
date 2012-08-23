# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pub do
    user
    sequence (:name) {|n| "In The Mountains of Madness #{n}"}
    description 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum
             cerebro. De carne lumbering animata corpora quaeritis. Summus
             brains sit, morbo vel maleficia? De apocalypsi gorger omero
             undead survivor dictum mauris. Hi mindless mortuis soulless 
             creaturas, imo evil stalking monstra adventus resi dentevil 
             vultus comedat cerebella viventium. Qui animated corpse, cricket 
             bat max brucks terribilem incessu zomby. The voodoo sacerdos 
             flesh eater, suscitat mortuos comedere carnem virus. Zonbi 
             tattered for solum oculi eorum defunctis go lum cerebro. Nescio 
             brains an Undead zombies. Sicut malus putrid voodoo horror. 
             Nigh tofth eliv ingdead.'

    factory :pub_with_stuffs do
      ignore do
        stuffs_count { rand(1..20) }
      end

      after :create do |pub, evaluator|
        FactoryGirl.create_list :stuff_with_comments, evaluator.stuffs_count, pub: pub
      end
    end
  end
end
