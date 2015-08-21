class Coordinate
  
  def initialize(row, col) 
    @col = col.to_i
    @row = row.to_i
  end
  
  def row
    @row
  end
  
  def col
    @col
  end
  
  def up
    unless @row-1<0
      Coordinate.new(@row-1 , @col)
    end
  end
  
  def down(mazeRowsSize)
    unless @row+1>mazeRowsSize
      Coordinate.new(@row+1 , @col.to_i)
    end
  end
  
  def left
    unless @col-1<0
      Coordinate.new(@row , @col-1)
    end
  end
  
  def right(mazeColsSize)
    unless @col+1>mazeColsSize
      Coordinate.new(@row , @col+1)
    end
  end
  
  def isEqual(coordinate)
    if self.row == coordinate.row && self.col == coordinate.col
      true
    else
      false
    end
  end
  
end