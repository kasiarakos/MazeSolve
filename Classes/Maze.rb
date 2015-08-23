require_relative 'Coordinate.rb'
require_relative 'Solution.rb'

class Maze
  @startCoordinate = nil
  @numRows = 0
  @numCols = 0
 
  def initialize(inputName)
    @filename = inputName
    @mazeArray = []
    @isSolved = false
    @solution = Solution.new
    @sortestSolution = Solution.new
  end
  
  
  
  def createMaze
    filename = @filename
    mazeSizeBuffer = []
    counter = 0
    
    file = File.new(filename, "r")
    while (line = file.gets)
      mazeSizeBuffer = line.split(" ")
      
      # searching for the start point
      mazeSizeBuffer.each_with_index do |c, index|
        if c.to_i == 9
          @startCoordinate = Coordinate.new(counter,index)
        end
      end
      
      @numCols = mazeSizeBuffer.size
      @mazeArray = @mazeArray << mazeSizeBuffer
        
      counter = counter + 1
    end
    @numRows = counter.to_i
  end

  def solveMaze
    
    currentCoordinate = @startCoordinate
    @solution.push(currentCoordinate)
    counter = 0
    weight = 9
    
    while !@isSolved
      
      # check every side if can step on
      returnCoordinate = lookNorth(currentCoordinate)
      unless returnCoordinate.isEqual(currentCoordinate)
        @mazeArray[currentCoordinate.row][currentCoordinate.col]=weight.to_s
        currentCoordinate = returnCoordinate
        @solution.push(currentCoordinate)
        @isSolved = checkFinish(currentCoordinate)
        weight=weight+1
        next
      end
      
      returnCoordinate = lookEast(currentCoordinate)
      unless returnCoordinate.isEqual(currentCoordinate)
        @mazeArray[currentCoordinate.row][currentCoordinate.col]=weight.to_s
        currentCoordinate = returnCoordinate
        @solution.push(currentCoordinate)
        @isSolved = checkFinish(currentCoordinate)
        weight=weight+1
        next
      end
      
      returnCoordinate = lookSouth(currentCoordinate)
      unless returnCoordinate.isEqual(currentCoordinate)
        @mazeArray[currentCoordinate.row][currentCoordinate.col]=weight.to_s
        currentCoordinate = returnCoordinate
        @solution.push(currentCoordinate)
        @isSolved = checkFinish(currentCoordinate)
        weight=weight+1
        next
      end
            
      returnCoordinate = lookWest(currentCoordinate)
      unless returnCoordinate.isEqual(currentCoordinate)
        @mazeArray[currentCoordinate.row][currentCoordinate.col]=weight.to_s
        # check_negbours(currentCoordinate, weight)
        currentCoordinate = returnCoordinate
        @solution.push(currentCoordinate)
        @isSolved = checkFinish(currentCoordinate)
        weight=weight+1
        next
      end
       
     @mazeArray[currentCoordinate.row][currentCoordinate.col]=3.to_s
     @solution.pop
     currentCoordinate = @solution.peek
     @isSolved = checkFinish(currentCoordinate)

    end
    
   puts "Robor found the target" 
   puts "The steps that took through the maze are the numbers greater than 10 with  asceding order."
   print "\n"
   (0..@numRows).each do |r|
      print(@mazeArray[r])
      print("\n")
    end
  end

  def findSortestPath   
      
      currentCoordinate = @startCoordinate
      while !currentCoordinate.isEqual(@solution.peek)
        step = checkNeighbors(currentCoordinate)
        @sortestSolution.push(currentCoordinate)
        currentCoordinate = step
      end
      @sortestSolution.push(currentCoordinate)
      
      print "\n"
      puts "end of sortest"
      puts "The sortest path inside the maze is shown below"
      print "\n"
      @sortestSolution.buildSteps
      print @sortestSolution.steps
    end
    
  def checkNeighbors(coordinate)
      
      neighbors = Hash.new
      neighborCoordinate = Hash.new
      
      up = coordinate.up
      unless up.nil?
        if @mazeArray[up.row][up.col].to_i==1
          return up
        end
        if @mazeArray[up.row][up.col].to_i>9
          neighbors[:up]=@mazeArray[up.row][up.col]
          neighborCoordinate[:up]=up
        end
      end
      
      right = coordinate.right(@numCols.to_i-1)
      unless right.nil?
        if @mazeArray[right.row][right.col].to_i==1
          return right
        end
        if @mazeArray[right.row][right.col].to_i>9
          neighbors[:right]=@mazeArray[right.row][right.col]
          neighborCoordinate[:right]=right
        end
      end
      
      left = coordinate.left
      unless left.nil?
        if @mazeArray[left.row][left.col].to_i==1
          return left
        end
        if @mazeArray[left.row][left.col].to_i>9
          neighbors[:left]=@mazeArray[left.row][left.col]
          neighborCoordinate[:left]=left
        end
      end
      
      down = coordinate.down(@numRows.to_i-1)
      unless down.nil?
        if @mazeArray[down.row][down.col].to_i==1
          return down
        end
        if @mazeArray[down.row][down.col].to_i>9
          neighbors[:down]=@mazeArray[down.row][down.col]
          neighborCoordinate[:down]=down
        end
      end
      
      max = neighbors.values.max
      step = neighbors.select { |k, v| v == max }.keys
      
      neighborCoordinate[step[0].to_sym]
      
    end
    
  def lookNorth(coordinate)
    up = coordinate.up
    unless up.nil?
      if checkSafe(up)
        up
      else
        coordinate
      end
    else
      coordinate
    end
  end
    
  def lookEast(coordinate)
    east = coordinate.right(@numCols.to_i-1)
    unless east.nil?
      if checkSafe(east)
        east
      else
        coordinate
      end
    else
      coordinate
    end
  end
    
  def lookSouth(coordinate)
    south = coordinate.down(@numRows.to_i-1)
    unless south.nil?
      if checkSafe(south)
        south
      else
        coordinate
      end
    else
      coordinate
    end
  end
  
  def lookWest(coordinate)
    left = coordinate.left
    unless left.nil?
      if checkSafe(left)
        left
      else
        coordinate
      end
    else
      coordinate
    end
  end
    
  def checkSafe(coordinate)
    if @mazeArray[coordinate.row][coordinate.col].to_i < 2
      true
    else
      false
    end
  end
    
  def checkFinish(coordinate)
    if @mazeArray[coordinate.row][coordinate.col].to_i == 1
      true
    else
      false
    end
  end

end