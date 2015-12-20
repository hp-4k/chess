module Chess

  class Knight < Piece
    
    def possible_moves(square)
      moves = []
      moves << Piece.offset_square(square, 1, 2)
      moves << Piece.offset_square(square, 2, 1)
      moves << Piece.offset_square(square, 2, -1)
      moves << Piece.offset_square(square, 1, -2)
      moves << Piece.offset_square(square, -1, -2)
      moves << Piece.offset_square(square, -2, -1)
      moves << Piece.offset_square(square, -2, 1)
      moves << Piece.offset_square(square, -1, 2)
      moves
    end
    
  end

end