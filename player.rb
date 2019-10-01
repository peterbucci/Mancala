class Player
  def initialize(name)
    @name = name
    @score = 0
  end

  def bank_seed
    @score += 1
    
    # Consider removing this eventually
    puts "#{@name} placed a single seed in their seed bank. They currently have #{@score} seed(s)"
    sleep(1)
  end
end