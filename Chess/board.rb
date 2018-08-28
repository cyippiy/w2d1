require_relative 'piece.rb'
require 'pp'

class Board
  
  attr_accessor :rows
  
  private
  
  attr_reader :sentinel
  
  public
  
  def initialize
    @rows = Array.new(8){Array.new(8){ nil }}
    @sentinel = nil
    @rows[0][3] = Queen.new()
    @rows[7][3] = Queen.new()
    @rows[0][0] = Rook.new()
    @rows[0][7] = Rook.new()
    @rows[7][0] = Rook.new()
    @rows[7][7] = Rook.new()
    @rows[0][1] = Knight.new()
    @rows[0][6] = Knight.new()
    @rows[7][1] = Knight.new()
    @rows[7][6] = Knight.new()
    @rows[0][2] = Bishop.new()
    @rows[0][5] = Bishop.new()
    @rows[7][2] = Bishop.new()
    @rows[7][5] = Bishop.new()
    @rows[0][4] = King.new()
    @rows[7][4] = King.new()
    
    (0...8).each do |i|
      @rows[1][i] = Pawn.new()
      @rows[6][i] = Pawn.new()
    end
  end
  
  def [](pos)
    x, y = pos
    self.rows[x][y]
  end
  
  def []=(pos,val)
    x,y = pos
    self.rows[x][y] = val
  end
  
  def move_piece(color,start_pos,end_pos)
    
    piece = self.[](start_pos)
      raise "No piece here" if piece == nil
      raise "There is something there" if self.[](end_pos) != nil
    self.[]=(end_pos, piece)
    self.[]=(start_pos, nil)
  end
  
  def valid_pos?(pos)
    x,y = pos
    range = (0..7)
    return false unless range.include?(x) and range.include?(y) 
    return true
  end
  
  def add_piece(piece,pos)
    
  end
  
  def inspect
    self.rows
  end
  
  
  
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  pp board.rows
  board.move_piece(nil, [1,1], [3,1])
  pp board.rows
end