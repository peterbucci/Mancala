class Board
  attr_reader :current_pit

  def initialize
    @pits = [4, 4, 4, 4, 4, 4]
    @current_pit = 0
  end

  def collect_seeds
    in_hand = @pits[@current_pit]
    @pits[@current_pit] = 0

    in_hand
  end

  def sow_seed
    @pits[@current_pit] += 1
  end

  def traverse
    @current_pit += 1
  end

  def empty?
    @pits.inject(:+) == 0
  end

  def select_pit(pit)
    @current_pit = pit
  end
end