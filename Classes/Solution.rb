class Solution
  @solution = nil
  @steps    = nil
  
  def initialize
    @solution = Array.new
  end
  
  def buildSteps
    @steps = Array.new
    (0..@solution.length-1).each do |s|
      @steps = @steps << "("+@solution[s].row.to_s+","+@solution[s].col.to_s+")"
    end
  end
  
  def push(coordinate)
    @solution.push(coordinate)
  end
  
  def pop
    @solution.pop
  end
  
  def peek
    @solution.last
  end
  
  def steps
    @steps
  end
end