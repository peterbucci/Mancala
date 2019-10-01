require_relative "player"
require_relative "board"

class Game
  def initialize
    @player_one = [Player.new, Board.new]
    @player_two = [Player.new, Board.new]

    play
  end

  def play
    current_player = @player_one

    until win?
      players_board = current_player[1]

      puts "Pick a number between 0 and 5."
      chosen_pit = gets.chomp.to_i

      players_board.select_pit(chosen_pit)
      seeds_in_hand = players_board.collect_seeds

      traverse_board(seeds_in_hand, current_player, current_player)
      current_player = (current_player == @player_one) ? @player_two : @player_one
    end

    puts "Game Over"
  end

  def traverse_board(seeds_in_hand, current_player, current_side)
    until seeds_in_hand == 0
      # Consider removing this eventually.
      puts "You have #{seeds_in_hand} seed(s) left."
      sleep(1)

      if current_side[1].current_pit == 5
        current_player[0].bank_seed if current_player == current_side
          
        current_side = (current_side == @player_one) ? @player_two : @player_one
        current_side[1].select_pit(-1)
      else
        current_side[1].traverse
        current_side[1].sow_seed
      end

      seeds_in_hand -= 1 if current_side[1].current_pit != 5 || current_player == current_side
    end

    # Consider removing this eventually.
    puts "You're now out of seeds"
    sleep(1)

    if current_side[1].current_pit > 0 || (current_player != current_side && current_side[1].current_pit == -1)
      puts "You ended your turn on a pit with seeds or your seed bank. You can keep going."
      sleep(1)

      if current_side[1].current_pit == -1
        puts "Pick a number between 0 and 5."
        chosen_pit = gets.chomp.to_i

        current_side[1].select_pit(chosen_pit)
      end

      seeds_in_hand = current_side[1].collect_seeds
      traverse_board(seeds_in_hand, current_player, current_side)
    end
  end

  def win?
    false
  end
end

Game.new