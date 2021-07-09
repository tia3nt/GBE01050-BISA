require_relative "villain.rb"

class Swordman < Villain

  def initialize(name, hitpoint, damage, troop, flee, limit)
  super(name, hitpoint, damage, troop, flee, limit)
  @units = "Swordman"
  end

  def attack(otherPlayer)
    puts "#{@name} the #{@units} has slash #{otherPlayer.isNamed} with #{@damage}
     attack damage."
     super
   end

end
