# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"
City.destroy_all
Gossip.destroy_all
PrivateMessage.destroy_all
Tag.destroy_all
User.destroy_all

10.times do
  City.create(name: Faker::Address.city,
              zip_code: Faker::Address.zip_code
  )
end

10.times do
  Tag.create(title: Faker::Lorem.sentence(word_count: 1))
end

10.times do
  PrivateMessage.create(content: Faker::Lorem.sentence(word_count: 10))
end

recipient_number = 1
# On crée une boucle pour "peupler" chaque ville
City.all.each do |city|
  # Creation de 10 utilisateurs
  10.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              description: Faker::Lorem.sentences(word_count: 10),
              email: Faker::Internet.safe_email,
              age: rand(18..60),
              city_id: city.id)
  end

  # Creation de 20 potins
  20.times do
    randomuser = User.all.where(city_id: city.id).sample
    gossip = Gossip.create(title: Faker::Lorem.sentence(word_count: 3),
                          content: Faker::Lorem.sentence(word_count: 10),
                          user_id: randomuser.id
    )
    # Mise à jour des tag_id de tout les gossips
    gossip.tags << Tag.all.sample

    # Mise à jour des gossip_id de tout les tags
    Tag.all.each do |tag|
    tag.gossips << gossip
    end
  end

  # Creation de 1 private message avec un nombre aléatoire de destinataires compris entre 1 et 3 maximum
  recipient_number = rand(1..3)
  
  if recipient_number == 1
    privatemessage = PrivateMessage.create(content: Faker::Lorem.sentence(word_count: 10),
                                                    sender_id: User.all.sample.id,
                                                    receiver_id: User.all.sample.id,
                                                    receiver2_id: nil,
                                                    receiver3_id: nil)
    
  elsif recipient_number == 2
    privatemessage = PrivateMessage.create(content: Faker::Lorem.sentence(word_count: 10),
                                          sender_id: User.all.sample.id,
                                          receiver_id: User.all.sample.id,
                                          receiver2_id: User.all.sample.id,
                                          receiver3_id: nil)
    
  elsif recipient_number == 3
    privatemessage = PrivateMessage.create(content: Faker::Lorem.sentence(word_count: 10),
                                          sender_id: User.all.sample.id,
                                          receiver_id: User.all.sample.id,
                                          receiver2_id: User.all.sample.id,
                                          receiver3_id: User.all.sample.id)
  end
end
