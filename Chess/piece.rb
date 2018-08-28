require 'colorize'
require_relative 'board.rb'
require_relative 'display.rb'

module SlidingPiece

  private

  HORIZONTAL_DIRS = [[0,1],[1,0]]
  DIAGONAL_DIRS = [[1,1],[-1,1]]

  public 

  def horizontal_dirs
    arr = []
    HORIZONTAL_DIRS.each do |dir|
      (-7..-1).each do |distance|
        arr << [dir[0]*distance, dir[1]*distance]
      end
      (1..7).each do |distance|
        arr << [dir[0]*distance, dir[1]*distance]
      end
    end
    arr
  end

  def diagonal_dirs
    arr = []
    DIAGONAL_DIRS.each do |dir|
      (-7..-1).each do |distance|
        arr << [dir[0]*distance, dir[1]*distance]
      end
      (1..7).each do |distance|
        arr << [dir[0]*distance, dir[1]*distance]
      end
    end
    arr
  end

  def moves
    move_list = []
    if move_dirs.include?(:Diagonal)
      move_list += diagonal_dirs
    end
    if move_dirs.include?(:Horizontal)
      move_list += horizontal_dirs
    end
    move_list
  end

  private

  def move_dirs
    [:Diagonal, :Horizontal]
  end

  def grow_unblock_moves_in_dir(dx,dy)
    
  end

end

module SteppingPiece

  public
  
  def moves
    if move_diffs.include?(:Step)
      [[1,1],[1,0],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]
    elsif move_diffs.include?(:Hop)
      [[-2,1],[-2,-1],[-1,2],[-1,-2],[1,2],[1,-2],[2,-1],[2,1]]
    end
  end
  
  private
  
  def move_diffs
    [:Step, :Hop]
  end
end

class Piece
  attr_reader :color
  attr_accessor :board, :pos 
  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
  end
  
  def to_s
    "   "
  end
  
  def empty?
    
  end
  
  def valid_moves
    results = []
    #grabs the pos of piece
    #gets move direction
    moves.each do |move|
      #check if move is within the board
      new_x = pos[0] + move[0]
      new_y = pos[1] + move[1]
      if board.valid_pos?([new_x,new_y])
        #check if another occupies/blocks the way
        if board[[new_x,new_y]].is_a?(NullPiece)
          results << [new_x,new_y] 
        end
      end
    end
    return results.reject {|v| blocked?(v)} unless self.is_a?(Knight)
    results
  end
  
  def blocked?(check_pos)
    check_pos2 = check_pos.dup
    while pos[0] != check_pos2[0] || pos[1] != check_pos2[1]
      check_pos2[0] += 1 if check_pos2[0] < pos[0]
      check_pos2[0] -= 1 if check_pos2[0] > pos[0]
      check_pos2[1] += 1 if check_pos2[1] < pos[1]
      check_pos2[1] -= 1 if check_pos2[1] > pos[1]
      return true if !board[[check_pos2[0],check_pos2[1]]].is_a?(NullPiece) &&
                    (pos[0] != check_pos2[0] || pos[1] != check_pos2[1])
    end
    return false
  end
  
  
  def pos=(val)
    pos = [val[0], val[1]]
  end
  
  def symbol
    
  end
  
  private
  
  def move_into_check?(end_pos)
    
  end
end

class NullPiece < Piece
  def initialize
  end
  def symbol
    "   "
  end
end

class Queen < Piece
  
  include SlidingPiece
  def symbol
    "Que"
  end
  
  protected
  def move_dirs
    [:Diagonal, :Horizontal]
  end
end

class Rook < Piece
  include SlidingPiece
  
  def symbol
    "Roo"
  end
  
  protected
  def move_dirs
    [:Horizontal]
  end
end

class Knight < Piece
  include SteppingPiece
  def symbol
    "Kni"
  end
  
  def move_diffs
    [:Hop]
  end
end

class Bishop < Piece
  include SlidingPiece
  
  def symbol
    "Bis"
  end
  protected
  def move_dirs
    [:Diagonal]
  end
end

class King < Piece
  include SteppingPiece
  def symbol
    "Kin"
  end
  
  def move_diffs
    [:Step]
  end
end

class Pawn < Piece
  def symbol
    "Paw"
  end
  
  def valid_moves
    moves = []
    forward_steps.each {|y| moves << [y+self.pos[0], self.pos[1]]}
    p side_attacks
    return moves + side_attacks
  end
  
  private
  
  def at_start_row?
    case @color
    when :B
      return true  if pos[0] == 1
    when :W
      return true if pos[0] == 6
    end
    false
  end
  
  def forward_dir
    case @color
    when :B
      return 1
    when :W
      return -1
    end
  end
  
  def forward_steps
    if at_start_row?
      return [forward_dir, forward_dir*2]
    else
      return [forward_dir]
    end
  end
  
  def side_attacks
    moves = []
    y, x1, x2 = forward_dir+self.pos[0], self.pos[1]+1, self.pos[1]-1
    unless self.board[[y,x1]].is_a?(NullPiece) && self.board[[y,x1]].color == self.color
      moves << [y,x1]
    end
    unless self.board[[y,x2]].is_a?(NullPiece) && self.board[[y,x2]].color == self.color
      moves << [y,x2]
    end
    moves
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  queen = board[[0,3]]
end