# -*- encoding : utf-8 -*-

u = User.new
u.name = 'volmer'
u.email = 'volmer@volmer.com'
u.password = '123456'
u.gender = :male
u.date_of_birth = 30.years.ago.to_date
u.bio = "Lover\nRocker\nKiller"
u.facebook_access_token = 'ACCESS_TOKEN'
u.facebook_url = 'http://facebook.com/'
u.location = 'Brasília-DF'
u.confirm!
u.save!

u2 = User.new
u2.name = 'volmerius'
u2.email = 'volmerius@volmer.com'
u2.password = '123456'
u2.gender = :male
u2.date_of_birth = 30.years.ago.to_date
u2.bio = "Lover\nRocker\nKiller"
u2.facebook_access_token = 'ACCESS_TOKEN'
u2.facebook_url = 'http://facebook.com/2'
u2.location = 'Brasília-DF'
u2.confirm!
u2.save!

r = Role.new
r.name = :admin
r.save!

u.roles << r

universe = Universe.new
universe.name = 'Vampiro: o Réquiem'
universe.description = 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris.'
universe.save!

r = universe.ranks.new name: 'Mortal', description: 'Mortallus'
r.level = 1
r.save!

r = universe.ranks.new name: 'Neófito', description: 'Neofittus', level: 2
r.level = 2
r.save!

r = universe.ranks.new name: 'Ancillae', description: 'Ancillaeus', level: 3
r.level = 3
r.save!

r = universe.ranks.new name: 'Ancião', description: 'Anciannus', level: 4
r.level = 4
r.save!


f = Forum.create!(universe_id: universe.id, name: 'Fórum de Testes', description: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris.')

t = f.topics.build(name: 'Tópico de Testes')
t.user = u
t.save!

p = t.posts.new(content: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris. Hi mindless mortuis soulless creaturas, imo evil stalking monstra adventus resi dentevil vultus comedat cerebella viventium. Qui animated corpse, cricket bat max brucks terribilem incessu zomby. The voodoo sacerdos flesh eater, suscitat mortuos comedere carnem virus. Zonbi tattered for solum oculi eorum defunctis go lum cerebro. Nescio brains an Undead zombies. Sicut malus putrid voodoo horror. Nigh tofth eliv ingdead.')
p.user = u
p.save!

pub = Pub.new universe_id: universe.id, name: 'Zombie Ipsum', subtitle: 'Zombie ipsum reversus ab viral inferno', description: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris. Hi mindless mortuis soulless creaturas, imo evil stalking monstra adventus resi dentevil vultus comedat cerebella viventium. Qui animated corpse, cricket bat max brucks terribilem incessu zomby. The voodoo sacerdos flesh eater, suscitat mortuos comedere carnem virus. Zonbi tattered for solum oculi eorum defunctis go lum cerebro. Nescio brains an Undead zombies. Sicut malus putrid voodoo horror. Nigh tofth eliv ingdead.'
pub.user = u
pub.save!

stuff = pub.stuffs.new name: 'Zombie Ipsum', content: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris. Hi mindless mortuis soulless creaturas, imo evil stalking monstra adventus resi dentevil vultus comedat cerebella viventium. Qui animated corpse, cricket bat max brucks terribilem incessu zomby. The voodoo sacerdos flesh eater, suscitat mortuos comedere carnem virus. Zonbi tattered for solum oculi eorum defunctis go lum cerebro. Nescio brains an Undead zombies. Sicut malus putrid voodoo horror. Nigh tofth eliv ingdead.'
stuff.save!

comment = stuff.comments.new content: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi gorger omero undead survivor dictum mauris. Hi mindless mortuis soulless creaturas, imo evil stalking monstra adventus resi dentevil vultus comedat cerebella viventium. Qui animated corpse, cricket bat max brucks terribilem incessu zomby. The voodoo sacerdos flesh eater, suscitat mortuos comedere carnem virus. Zonbi tattered for solum oculi eorum defunctis go lum cerebro. Nescio brains an Undead zombies. Sicut malus putrid voodoo horror. Nigh tofth eliv ingdead.'
comment.user = u
comment.save!

