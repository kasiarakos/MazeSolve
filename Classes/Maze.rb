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
  end
  
  public
  
    def createMaze
      filename = @filename
      mazeSizeBuffer = []
      counter = 0
      
      file = File.new(filename, "r")
      while (line = file.gets)
        mazeSizeBuffer = line.split(" ")
        
        mazeSizeBuffer.each_with_index do |c, index|
          if c.to_i == 9
            @startCoordinate = Coordinate.new(counter,index)
          end
        end
        
        @numCols = mazeSizeBuffer.size
        @mazeArray = @mazeArray << mazeSizeBuffer
     
        a = Array.new
       
        counter = counter + 1
      end
      @numRows = counter.to_i
    end

    def solveMaze
      
      currentCoordinate = @startCoordinate
      @solution.push(currentCoordinate)
       
      counter = 0
      while !@isSolved

        returnCoordinate = lookNorth(currentCoordinate)
        unless returnCoordinate.isEqual(currentCoordinate)
          
          @mazeArray[currentCoordinate.row][currentCoordinate.col]=2
          currentCoordinate = returnCoordinate
          @solution.push(currentCoordinate)
          @isSolved = checkFinish(currentCoordinate)
          next
        end
        
        returnCoordinate = lookEast(currentCoordinate)
        unless returnCoordinate.isEqual(currentCoordinate)
          @mazeArray[currentCoordinate.row][currentCoordinate.col]=2
          currentCoordinate = returnCoordinate
          @solution.push(currentCoordinate)
          @isSolved = checkFinish(currentCoordinate)
          next
        end
        
        returnCoordinate = lookSouth(currentCoordinate)
        unless returnCoordinate.isEqual(currentCoordinate)
          @mazeArray[currentCoordinate.row][currentCoordinate.col]=2
          currentCoordinate = returnCoordinate
          @solution.push(currentCoordinate)
          @isSolved = checkFinish(currentCoordinate)
          next
        end
              
        returnCoordinate = lookWest(currentCoordinate)
        unless returnCoordinate.isEqual(currentCoordinate)
          @mazeArray[currentCoordinate.row][currentCoordinate.col]=2
          currentCoordinate = returnCoordinate
          @solution.push(currentCoordinate)
          @isSolved = checkFinish(currentCoordinate)
          next
        end
         
         @mazeArray[currentCoordinate.row][currentCoordinate.col]=3
         @solution.pop
         currentCoordinate = @solution.peek
         @isSolved = checkFinish(currentCoordinate)

      end
      
      puts("teleiwse")
      
      
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
      puts(@mazeArray[coordinate.row][coordinate.col].to_s+"   ")
      if @mazeArray[coordinate.row][coordinate.col].to_i == 1
        true
      else
        false
      end
    end


end