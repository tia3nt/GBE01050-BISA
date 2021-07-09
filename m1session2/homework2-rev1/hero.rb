require_relative "player.rb"

class Hero < Player
    def initialize(name, hitpoint, damage, deflect, heal)
      super(name, hitpoint, damage)
      @deflect = deflect
      @heal = heal
    end

    def heal(otherPlayer)
      puts "#{@name} restore health point of #{otherPlayer.isNamed} for #{@heal} point"
      otherPlayer.isHeal(@heal)
    end

    def attack (otherPlayer)
      puts "#{@name} attacks #{otherPlayer.isNamed} with #{@damage} damage."
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
