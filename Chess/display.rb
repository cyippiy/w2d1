require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'
require 'pp'

class Display
  attr_reader :board
  attr_accessor :selected_piece
  
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
    @selected_piece = nil
  end
  
  def render
    while true
      begin
      # system("clear")
      self.board.rows.each_with_index do |row, i|
        row.each_with_index do |square, j|
          piece = square.symbol
          if square.color == :W
            piece = piece.colorize(:white)
          elsif square.color == :B
            piece = piece.colorize(:background=>:yellow, :color=>:black)
          else
            piece = piece.colorize(:background=>:white)
          end
          if @cursor.cursor_pos == [i,j]
            piece = piece.colorize(:background => :red)
          end
          if @cursor.selected && self.selected_piece == [i,j]
            piece = piece.colorize(:background => :blue)
          end
          print piece + " "
        end
        puts " "
      end
      new_input = @cursor.get_input
      self.selected_piece = new_input  if new_input != nil && @cursor.selected
      if !@cursor.selected && self.selected_piece != nil
        board.move_piece(:B,self.selected_piece,@cursor.cursor_pos)
        self.selected_piece = nil 
      end
      p board.in_check?(:B)
      p board.in_check?(:W)
      rescue
        retry
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  # queen = board[[0,3]]
  # p rook.valid_moves
  # p queen.valid_moves
  display.render
end