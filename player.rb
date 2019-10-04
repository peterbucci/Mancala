class Player
  attr_reader :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def bank_seed
    @score += 1
    
    # Consider removing this eventually
    puts "#{@name} placed a single seed in their seed bank and have #{@score} seed(s) banked."
    sleep(1)
  end

  def get_pos
    puts "Pick a number between 0 and 5."
    gets.chomp
  end
end