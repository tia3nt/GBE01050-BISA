require_relative "player.rb"

class Hero < Player
    def initialize(name, hitpoint, damage, deflect)
      super(name, hitpoint, damage)
      @deflect = deflect
    end

    def attack (otherPlayer)
      puts "#{@name} attacks #{otherPlayer.isAttack} with #{@damage} damage."
      super
    end

    #reduce other player hitpoint when gotAttack
      def gotAttack(damage)
        @@probsDeflects = rand(1..100)
        if @@probsDeflects <= @deflect and @deflect > 0
            puts "#{@name} deflects the attack."
          else
              super
        end
      end

end
