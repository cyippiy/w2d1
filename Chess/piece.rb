class Piece
  def inspect
    "P"
  end
end

class NullPiece < Piece
  
end

class Queen < Piece
  def inspect
    "Q"
  end
end

class Rook < Piece
  def inspect
    "R"
  end
end

class Knight < Piece
  def inspect
    "K"
  end
end