class Player
    attr_accessor :name, :hitpoint, :damage

    def initialize(name, hitpoint, damage)
        @name = name
        @hitpoint = hitpoint
        @damage = damage
    end

    def to_s
        "#{@name} has #{@hitpoint} and #{@damage}"
    end


    def attack(otherPlayer)
        puts "#{@name} attacks #{otherPlayer.name} with #{@damage} damage"
        otherPlayer.hitpoint -= @damage
        puts "#{otherPlayer.name} has #{otherPlayer.hitpoint} hitpoint and #{otherPlayer.damage} attack damage"
    end

    def gameLoose?
        return @hitpoint<=0
    end

end

player1= Player.new("Jin Kai",100,50)
player2= Player.new("Khotun Khan",500,50)

puts player1
puts player2

begin
    player1.attack(player2)
    player2.attack(player1)
end until player1.gameLoose? || player2.gameLoose?
