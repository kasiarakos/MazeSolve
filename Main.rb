require_relative 'Classes/Maze.rb'

m = Maze.new('kasiarakos.txt')
m.createMaze
m.solveMaze
m.findSortestPath
