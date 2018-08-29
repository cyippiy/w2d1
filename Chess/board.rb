require_relative 'piece.rb'
require 'pp'
require 'byebug'
require 'colorize'

class Board
  
  attr_accessor :rows
  
  private
  
  attr_reader :sentinel
  
  public
  
  def initialize
    @rows = Array.new(8){Array.new(8){ NullPiece.new() }}
    @sentinel = nil
    @rows[0][3] = Queen.new(:B, self, [0, 3])
    @rows[7][3] = Queen.new(:W, self, [7, 3])
    @rows[0][0] = Rook.new(:B, self, [0, 0])
    @rows[0][7] = Rook.new(:B, self, [0, 7])
    @rows[7][0] = Rook.new(:W, self, [7, 0])
    @rows[7][7] = Rook.new(:W, self, [7, 7])
    @rows[0][1] = Knight.new(:B, self, [0, 1])
    @rows[0][6] = Knight.new(:B, self, [0, 6])
    @rows[7][1] = Knight.new(:W, self, [7, 1])
    @rows[7][6] = Knight.new(:W, self, [7, 6])
    @rows[0][2] = Bishop.new(:B, self, [0, 2])
    @rows[0][5] = Bishop.new(:B, self, [0, 5])
    @rows[7][2] = Bishop.new(:W, self, [7, 2])
    @rows[7][5] = Bishop.new(:W, self, [7, 5])
    @rows[0][4] = King.new(:B, self, [0, 4])
    @rows[7][4] = King.new(:W, self, [7, 4])
    
    (0...8).each do |i|
      @rows[1][i] = Pawn.new(:B, self, [1, i])
      @rows[6][i] = Pawn.new(:W, self, [6, i])
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
      raise "No piece here" if piece.is_a?(NullPiece)
    if piece.valid_moves.include?(end_pos)
      self.[]=(start_pos, NullPiece.new)
      self.[]=(end_pos, add_piece(piece, end_pos))
    end
  end
  
  def valid_pos?(pos)
    x,y = pos
    range = (0..7)
    return false unless range.include?(x) and range.include?(y) 
    return true
  end
  
  def add_piece(piece,pos)
    case piece
    when Queen
      Queen.new(piece.color, self, pos)
    when Rook
      Rook.new(piece.color, self, pos)
    when Bishop
      Bishop.new(piece.color, self, pos)
    when King
      King.new(piece.color, self, pos)
    when Knight
      Knight.new(piece.color, self, pos)
    when Pawn
      Pawn.new(piece.color, self, pos)
    end
  end
  
  def inspect
    self.rows
  end
  
  def find_king(color)
    (0..7).each do |i|
      (0..7).each do |j|
        return [i,j] if self[[i,j]].is_a?(King) and self[[i,j]].color == color
      end
    end
    return nil
  end
  
  def in_check?(color)
    #find position of the color's king
    king_pos = find_king(color)
    (0..7).each do |i|
      (0..7).each do |j|
        return true if !self[[i,j]].is_a?(NullPiece) && 
                        self[[i,j]].color != color && 
                        self[[i,j]].valid_moves.include?(king_pos)
      end
    end
    return false
    #see if any enemy color can move into king pos
  end
  
  def checkmate?(color)
    
    king_pos = find_king(color)
    (0..7).each do |i|
      (0..7).each do |j|
        if !self[[i,j]].is_a?(NullPiece) && self[[i,j]].color == color
          try_these = self[[i,j]].valid_moves
        end
      end
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  pp board.rows
  board.move_piece(nil, [1,1], [3,1])
  pp board.rows
end