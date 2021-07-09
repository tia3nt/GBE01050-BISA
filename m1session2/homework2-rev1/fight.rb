require_relative "hero.rb"
require_relative "spearman.rb"
require_relative "swordman.rb"
require_relative "archer.rb"
require_relative "cavalry.rb"


jin = Hero.new("Jin Sakai", 100, 50, 80, 20)
yuna = Hero.new("Yuna", 300, 60, 0, 0)
sensei = Hero.new("Sensei Ishikawa", 120, 70, 0, 0)
spear1 = Spearman.new("Ganbaatar", 100, 20,"Mongolian", 50, 50)
spear2 = Spearman.new("Batjargal", 100, 20, "Mongolian", 50, 50)
archer1 = Archer.new("Monkhbat", 120, 10, "Mongolian", 50, 50)
sword1= Swordman.new("Altan", 200, 40, "Mongolian", 50, 50)
cavalry1= Cavalry.new("Chuluun", 300, 15, "Mongolian", 50, 50)

mongolians = Array[spear1, spear2, archer1, sword1, cavalry1]
heroes = Array[jin, yuna, sensei]

heroes.each {
  |hero|
  puts hero
}

puts "\n"

mongolians.each {
  |mongol|
  puts mongol
}

puts "\n \n"

begin

mongol=mongolians[rand(0..mongolians.length-1)]
hero = heroes[rand(0..heroes.length-1)]

if hero = jin
  if rand(0..100)>50
    begin
    hero2 = heroes[rand(0..heroes.length-1)]
    end until hero2 != hero
    hero.heal(hero2)
    puts hero2
  end
else

    hero.attack(mongol)
    puts mongol

    if mongol.isLoose?
      puts mongol.looser
      mongolians.delete(mongol)
      if mongolians.length==0
        puts "All Villains troop has been slain"
        break
      end

    elsif mongol.flee != nil
        puts mongol.flee
        mongolians.delete(mongol)
        if mongolians.length==0
          puts "all villains troop has flee from battle field, our Hero won"
          break
        end
    end
  end
  
puts "\n"

mongol=mongolians[rand(0..mongolians.length-1)]
hero = heroes[rand(0..heroes.length-1)]

mongol.attack(hero)
puts hero
puts "\n"
if hero.isLoose?
  puts hero.looser
  break if hero == jin
  heroes.delete(hero)
end

end until jin.isLoose? or mongolians.length==0
