class Player
  def initialize(name)
    @name = name
    @score = 0
  end

  def bank_seed
    @score += 1
    
    # Consider removing this eventually
    puts "#{@name} has scored a point. They currently have #{@score} point(s)"
    sleep(1)
  end
end