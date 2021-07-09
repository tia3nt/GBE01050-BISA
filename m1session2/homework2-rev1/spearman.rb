require_relative "villain.rb"


class Spearman < Villain

  def initialize(name, hitpoint, damage, troop, flee, limit)
  super(name, hitpoint, damage, troop, flee, limit)
  @units = "Spearman"
  end

  def attack(otherPlayer)
    puts "#{@name} the #{@units} has Thrust #{otherPlayer.isNamed} with #{@damage}
    attack damage."
    super
  end


end
