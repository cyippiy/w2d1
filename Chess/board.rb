require_relative 'piece.rb'


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
    # @rows[0][1] = Bishop.new()
    # @rows[0][6] = Bishop.new()
    # @rows[7][1] = Bishop.new()
    # @rows[7][6] = Bishop.new()
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
    
  end
  
  def add_piece(piece,pos)
    
  end
  
  
  
end

