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
      self.board.rows.each do |row|
        str = []
        row.each do |square|
          str << square
        end
        p str
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