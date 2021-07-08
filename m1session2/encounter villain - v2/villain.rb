require_relative "player.rb"
class Villain < Player
  def initialize(name, hitpoint, damage, troop, units, howToStrike, flee, limit)
    super(name, hitpoint, damage)
    @flee = flee
    @limit = limit
    @troop = troop
    @units = units
    @howToStrike = howToStrike
  end

  def attack(otherPlayer)
    puts "#@name the #{@troop} #{@units} has #{@howToStrike}
    #{otherPlayer.isAttack} with #{@damage} attack damage"
    super
  end

  def looser
    "#{@name} the #{@troop} #{@units} has been slain."
  end

  def isAttack
    "#{@name} the #{@troop} #{@units}"
  end

  def flee
    if @hitpoint <= @limit
      if rand(1..100) <= @flee
        "#{@troop} #{@units} flee from battle field with #{@hitpoint} hitpoint."
      end
    end
  end

end
