class Solution
  @solution = nil
  @steps    = nil
  
  def initialize
    @solution = Array.new
    
  end
  
  def buildSteps
    @steps    = Array.new
    tempSolution = @solution

    while !solution.empty?
      @steps.push(@solution.pop)
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
  
  def getSteps
    @steps
  end
end