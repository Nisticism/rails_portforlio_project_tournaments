# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tournaments = [{game_title: "Starcraft 2", name: "End of Year Starcraft 2 Tournament", prize_pool: 200},
         {game_title: "Halo", name: "Halo Tournament", prize_pool: 100},
         {game_title: "SSBM", name: "Super Smash Bros. Melee Tournament", prize_pool: 500},
         {game_title: "Call of Duty", name: "Call of Duty Tournament", prize_pool: 200},
         {game_title: "Counter-Strike", name: "Counter-Strike Tournament", prize_pool: 100},
         {game_title: "Starcraft 2", name: "World Championship", prize_pool: 1000}]

tournaments.each do |tournament|
  Tournament.create(tournament)
end

Starcraft2 = Game.find_by(title: "Starcraft 2")
Starcraft2.release_date = '2009-01-10'
Starcraft2.genre = "Real Time Strategy"
Starcraft2.save
SSBM = Game.find_by_title("SSBM")
SSBM.release_date = '1998-05-02'
SSBM.genre = "Fighting"
SSBM.save
