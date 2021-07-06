require "./player"

player1 = Player.new("Jin Sakai", 100, 50, "hero")
player2 = Player.new("Khotun Khan", 500, 50, "magician")

puts player1
puts player2

begin
  player1.attack(player2)
  puts player2
  if player2.isLoose?
    puts player2.looser
    break
  end
  player2.attack(player1)
  puts player1
  if player1.isLoose?
    puts player1.looser
    break
  end
end until player1.isLoose? or player2.isLoose?
