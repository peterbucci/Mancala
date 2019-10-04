require_relative "player"
require_relative "board"

class Game
  def initialize
    @player_one = [Player.new("Player One"), Board.new]
    @player_two = [Player.new("Player Two"), Board.new]

    play
  end

  def play
    @current_player = @player_one

    until win?
      puts "\n" + "#{@current_player[0].name}'s Turn"
      puts "Current Board: #{@player_one[1].pits} #{@player_two[1].pits}"
      chosen_pit = valid_move?(@current_player[0].get_pos)


      @current_player[1].select_pit(chosen_pit)
      seeds_in_hand = @current_player[1].collect_seeds

      traverse_board(seeds_in_hand, @current_player)
      @current_player = (@current_player == @player_one) ? @player_two : @player_one
    end

    puts "Game Over"
  end

  def valid_move?(user_input)
    if /^[0-5]$/.match(user_input)
      pos = user_input.to_i
      @current_player[1].select_pit(pos)

      @current_player[1].current_pit_contents > 0 ? (return pos) : (puts "Selected pit is empty, please try again.")
    else
      puts "Invalid input, please try again."
    end

    valid_move?(@current_player[0].get_pos)
  end

  def traverse_board(seeds_in_hand, current_side)
    until seeds_in_hand == 0
      # Consider removing this eventually.
      puts "Current Board: #{@player_one[1].pits} #{@player_two[1].pits}"
      gets
      puts "You have #{seeds_in_hand} seed(s) left."
      sleep(1)

      if current_side[1].current_pit == 5
        current_side = enter_bank(current_side)
      else
        current_side[1].traverse
        current_side[1].sow_seed
      end

      seeds_in_hand -= 1 if current_side[1].current_pit != -1 || @current_player != current_side
    end

    # Consider removing this eventually.
    puts "You're now out of seeds"
    sleep(1)

    continue_turn?(current_side)
  end

  def enter_bank(current_side)
    if @current_player == current_side 
      @current_player[0].bank_seed 
    else 
      puts "You skip your opponents seed bank."
      sleep(1)
    end

    current_side = (current_side == @player_one) ? @player_two : @player_one
    current_side[1].select_pit(-1)
    
    current_side
  end

  def continue_turn?(current_side)
    if current_side[1].current_pit_contents > 1 || (@current_player != current_side && current_side[1].current_pit == -1)
      puts "You ended your turn on a pit with seeds or your seed bank. You can keep going."
      sleep(1)

      if current_side[1].current_pit == -1
        puts "Pick a number between 0 and 5."
        chosen_pit = valid_move?(gets.chomp)

        @current_player[1].select_pit(chosen_pit)
        seeds_in_hand = @current_player[1].collect_seeds
        traverse_board(seeds_in_hand, @current_player)
      else
        seeds_in_hand = current_side[1].collect_seeds
        traverse_board(seeds_in_hand, current_side)
      end
    end
  end

  def win?
    player_one_remaining_pits = @player_one[1].pits.inject(:+)
    player_two_remaining_pits = @player_two[1].pits.inject(:+)
    player_one_remaining_pits == 0 || player_two_remaining_pits == 0
  end
end

Game.new