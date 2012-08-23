# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user
    topic
    content 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum
             cerebro. De carne lumbering animata corpora quaeritis. Summus
             brains sit, morbo vel maleficia? De apocalypsi gorger omero
             undead survivor dictum mauris. Hi mindless mortuis soulless 
             creaturas, imo evil stalking monstra adventus resi dentevil 
             vultus comedat cerebella viventium.'
  end
end
