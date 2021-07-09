require_relative "villain.rb"

class Archer < Villain
  def initialize(name, hitpoint, damage, troop, flee, limit)
  super(name, hitpoint, damage, troop, flee, limit)
  @units = "Archer"
  end
  def attack(otherPlayer)
    puts "#@name the Archer has shoot #{otherPlayer.isNamed} with
     arrows with #{@damage} attack damage"
    super
  end

end
