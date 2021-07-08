class Player

  def initialize(name, hitpoint, damage)
    @name, @hitpoint, @damage = name, hitpoint, damage
  end

def to_s
  "#{@name} has #{@hitpoint} hitpoint and #{@damage} attack damage."
end

#reduce other player hitpoint when gotAttack
  def gotAttack(damage)
      @hitpoint -= damage
  end

#return other player name's being attacks
def isAttack
  "#{@name}"
end

#when a player attack the other player
  def attack(otherPlayer)
      otherPlayer.gotAttack(@damage)
  end

#check if player already loose
  def isLoose?
    @hitpoint <= 0
  end

  #name the looser
  def looser
    "#{@name} dies."
  end

end
