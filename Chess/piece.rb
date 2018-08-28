require 'colorize'
class Piece
  
end

class NullPiece < Piece
  
end

class Queen < Piece
  def inspect
    "Que"
  end
end

class Rook < Piece
  def inspect
    "Roo"
  end
end

class Knight < Piece
  def inspect
    "Kni"
  end
end

class Bishop < Piece
  def inspect
    "Bis"
  end
end

class King < Piece
  def inspect
    "Kin"
  end
end

class Pawn < Piece
  def inspect
    "Paw"
  end
end