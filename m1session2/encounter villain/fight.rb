require_relative "hero.rb"
require_relative "spearman.rb"
require_relative "swordman.rb"
require_relative "archer.rb"
require_relative "cavalry.rb"


jin = Hero.new("Jin Sakai", 100, 50, 80)
spear1 = Spearman.new("Ganbaatar", 100, 20,"Mongolian", 50, 50)
spear2 = Spearman.new("Batjargal", 100, 20, "Mongolian", 50, 50)
archer1 = Archer.new("Monkhbat", 120, 10, "Mongolian", 50, 50)
sword1= Swordman.new("Altan", 200, 40, "Mongolian", 50, 50)
cavalry = Cavalry.new("Chuluun", 300, 25, "Mongolian", 50, 50)

mongolians = Array[spear1, spear2, archer1, sword1, cavalry]

puts jin
mongolians.each {
  |mongol|
  puts mongol
}

puts "\n \n"

begin

mongol=mongolians[rand(0..mongolians.length-1)]
jin.attack(mongol)
puts mongol

if mongol.isLoose?
  puts mongol.looser
  mongolians.delete(mongol)
  if mongolians.length==0
    puts "All Villains troop has been slain"
    break
  end
  mongol=mongolians[rand(0..mongolians.length-1)]


elsif mongol.flee != nil
  puts mongol.flee
  mongolians.delete(mongol)
  if mongolians.length==0
    puts "all villains troop has flee from battle field, our Hero won"
    break
  end
  mongol=mongolians[rand(0..mongolians.length-1)]
end
puts "\n"

mongol.attack(jin)
puts jin
puts "\n"
if jin.isLoose?
  jin.looser
  break
end

end until jin.isLoose? or mongolians.length==0
