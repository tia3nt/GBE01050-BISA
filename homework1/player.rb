class Player

  def initialize(name, hitpoint, damage, role)
    @name, @hitpoint, @damage, @role = name, hitpoint, damage, role
  end

def to_s
  "#{@name} has #{@hitpoint} hitpoint and #{@damage} attack damage"
end

#reduce other player hitpoint when gotAttack
  def gotAttack(damage)
    @@probsDeflects = Array['deflect', 'deflect', 'deflect', 'deflect', 'deflect',
       'deflect', 'deflect', 'deflect', 'got hit', 'got hit' ]

    @@probs = @@probsDeflects[rand(0..9)]
    if @role.upcase == "HERO"
      if @@probs == 'deflect'
        puts "#{@name} deflects the attack."
        @hitpoint += damage
      end
    end
      @hitpoint -= damage
  end

#return other player name's being attacks
def isAttack
  "#{@name}"
end

#when a player attack the other player
  def attack(otherPlayer)
    @@enemyName = otherPlayer.isAttack
    puts "#{@name} attacks #{@@enemyName} with #{@damage} damage."
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
