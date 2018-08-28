require 'colorize'
class Piece
  
end

class NullPiece < Piece
  
end

class Queen < Piece
  def to_s
    "Que"
  end
end

class Rook < Piece
  def to_s
    "Roo"
  end
end

class Knight < Piece
  def to_s
    "Kni"
  end
end

class Bishop < Piece
  def to_s
    "Bis"
  end
end

class King < Piece
  def to_s
    "Kin"
  end
end

class Pawn < Piece
  def to_s
    "Paw"
  end
end