# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

polo = User.new(first_name: "paul", last_name:"coco",email: "polo@live.fr", password: "polopolo")
polo.save

michou = User.new(first_name: "michel", last_name:"dubois", email: "michou@live.fr", password: "michou")
michou.save

beber = User.new(first_name: "bertrant", last_name:"depuis",email: "beber@live.fr", password: "beber")
beber.save


place_tennis = Place.new(name: "Le tennis de Polo", address: "11 rue du camping à Vanne")
place_tennis.user = polo
place_tennis.save

place_petanque = Place.new(name: "Le terrain de pétanque de michou", address: "11 rue du Midi à Marseille")
place_petanque.user = michou
place_petanque.save

booking_tennis = Booking.new(start_time: 13/04/2017, end_time: 13/04/2017)
booking_tennis.place = place_tennis
booking_tennis.user = beber
booking_tennis.save

booking_petanque = Booking.new(start_time: 13/04/2017, end_time: 13/04/2017)
booking_petanque.place = place_petanque
booking_petanque.user = beber
booking_petanque.save

whitelist1 = Whitelist.new(email: "pedro@live.fr")
whitelist1.place = place_tennis
whitelist1.save

whitelist2 = Whitelist.new(email: "toto@live.fr")
whitelist2.place = place_petanque
whitelist2.save

