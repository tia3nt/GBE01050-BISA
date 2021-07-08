require_relative "player.rb"
class Villain < Player
  def initialize(name, hitpoint, damage, troop, flee, limit)
    super(name, hitpoint, damage)
    @flee = flee
    @limit = limit
    @troop = troop
    @units=""
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
