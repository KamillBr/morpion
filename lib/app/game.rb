require 'bundler'
Bundler.require

require_relative 'player'
require_relative 'board_case'
require_relative 'board'

class Game
  attr_accessor :player1, :player2, :board

  def initialize
    # création des joueurs
    puts "Quel est ton nom (X)"
    print "> "
    name_player1 = gets.chomp
    @player1 = Player.new("#{name = name_player1}", "#{symbol = "X"}")
    # @@player << @player1
    #sleep(2)
    puts "OK ! joueur 2 quel est ton nom (O)"
    print "> "
    name_player2 = gets.chomp
    @player2 = Player.new("#{name = name_player2}", "#{symbol = "O"}")
    # @@player << @player2
    puts "Bienvenue #{name_player1} et #{name_player2}"
    @board = Board.new #création plateau
 
  end #initialize
  
  def go
    # On lance la partie, 
    puts " #{player1.player_name} va jouer le premier"
    play_turn 
  end

  def play_turn
    puts "#{@board.start}"
    puts "#{@board.top}"
    #1) demande au bon joueur ce qu'il souhaite faire
    #2) change la BoardCase jouée en fonction de la valeur du joueur (X ou O)
    turn = 1
    while turn < 10 && !victory do # Morpion = 9 tours
        if turn.odd?  # tour impair pour joueur 1 
          sleep (2)
          puts "#{@board.start}"
          puts "#{@board.show_game}"
          puts "C'est ton tour #{player1.player_name}. Tu choisis (lettre de A à C en majuscule et chiffre de 1 à 3, ex : A1)"
          print ">"
          next_move = gets.chomp
          if @board.get_cases_array.any? {|x| x.position == next_move} # La position est exacte ...
            @board.get_cases_array.each do |x| 
              if x.position == next_move
                if x.content == " "     # ... et le contenu de la case est vide.
                  x.content = "#{player1.player_symbol}"
                  if self.victory # condition victoire p1
                    puts "#{@board.start}"
                    puts "#{@board.show_game}"
                    puts "#{player1.player_name} a remporté la partie !"
                  end               
                else
                  puts "La case est déjà renseignée"
                  turn -=1
                end # On veut rejouer le tour car une case est déja renseignée
              end
            end
          else
            puts "Cette case n'existe pas'"
            turn -=1 # On veut rejouer le tour car la case choisie n'existe pas
          end
        elsif !victory  # tour pair pour joueur 2
          sleep (2)
          puts "#{@board.start}"
          puts "#{@board.show_game}"
          puts "C'est ton tour #{player2.player_name}. Tu choisis (lettre de A à C en majuscule et chiffre de 1 à 3, ex : A1)"
          print ">"
          next_move = gets.chomp
          if  @board.get_cases_array.any? {|x| x.position == next_move}  # La position est exacte ...
            @board.get_cases_array.each do |x|
              if x.position == next_move
                if x.content == " "        # ... et le contenu de la case est vide.
                  x.content = "#{player2.player_symbol}" 
                  if self.victory #  condition victoire p2
                    puts "#{@board.start}"
                    puts "#{@board.show_game}"
                    puts "#{player2.player_name} a remporté la partie !"
                  end
                else
                  puts "Case déjà utilisée"
                  turn -=1
                end
              end
            end
          else
            puts "Cette case n'existe pas"
            turn -=1 # On veut rejouer le tour car la case choisie n'existe pas
          end
        end
        turn += 1
    end # boucle while
    if turn == 10 && !victory
      puts "Match nul!"
    end
    puts "La partie est terminée"
  end # play_turn

  def victory
    # une méthode qui vérifie le plateau et indique s'il y a un vainqueur 
    if @board.get_cases_array[0].content == @board.get_cases_array[1].content && @board.get_cases_array[1].content == @board.get_cases_array[2].content && @board.get_cases_array[2].content !=" "
      return true #verif ligne A
    elsif @board.get_cases_array[3].content == @board.get_cases_array[4].content && @board.get_cases_array[4].content == @board.get_cases_array[5].content && @board.get_cases_array[5].content !=" "
      return true #verif ligne B
    elsif @board.get_cases_array[6].content == @board.get_cases_array[7].content && @board.get_cases_array[7].content == @board.get_cases_array[8].content && @board.get_cases_array[8].content !=" "
      return true #verif ligne C
    elsif @board.get_cases_array[0].content == @board.get_cases_array[3].content && @board.get_cases_array[3].content == @board.get_cases_array[6].content && @board.get_cases_array[6].content !=" "
      return true #verif col 1
    elsif @board.get_cases_array[1].content == @board.get_cases_array[4].content && @board.get_cases_array[4].content == @board.get_cases_array[7].content && @board.get_cases_array[7].content !=" "
      return true #verif col 2
    elsif @board.get_cases_array[2].content == @board.get_cases_array[5].content && @board.get_cases_array[5].content == @board.get_cases_array[8].content && @board.get_cases_array[8].content !=" "
      return true #verif col 3
    elsif @board.get_cases_array[0].content == @board.get_cases_array[4].content && @board.get_cases_array[4].content == @board.get_cases_array[8].content && @board.get_cases_array[8].content !=" "
      return true #verif diag gauche droite
    elsif @board.get_cases_array[2].content == @board.get_cases_array[4].content && @board.get_cases_array[4].content == @board.get_cases_array[6].content && @board.get_cases_array[6].content !=" "
      return true #verif diag droite gauche
    else
      return false
    end
  end #victory
 
end # end Game