require_relative "villain.rb"

class Cavalry < Villain

  def initialize(name, hitpoint, damage, troop, flee, limit)
  super(name, hitpoint, damage, troop, flee, limit)
  @units = "Cavalry"
  end

  def attack(otherPlayer)
    puts "#{@name} from #{@units} units has shower #{otherPlayer.isAttack} with
    buriat bow with #@damage attack damage."
    super
  end
  

end
