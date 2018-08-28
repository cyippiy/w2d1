require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'
require 'pp'

class Display
  attr_reader :board
  
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end
  
  def render
    while true
      system("clear")
      self.board.rows.each_with_index do |row, i|
        row.each_with_index do |square, j|
          piece = square.to_s
          if @cursor.selected && @cursor.cursor_pos == [i,j]
            piece = piece.colorize(:blue)
          end
          print piece + " "
        end
        puts ""
      end
      @cursor.get_input
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
end