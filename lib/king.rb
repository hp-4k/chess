module Chess

  class King < Piece
    
    def possible_moves(square, board_state)
      moves = []
      moves << offset_square(square, 1, 1)
      moves << offset_square(square, 1, 0)
      moves << offset_square(square, 1, -1)
      moves << offset_square(square, 0, -1)
      moves << offset_square(square, -1, -1)
      moves << offset_square(square, -1, 0)
      moves << offset_square(square, -1, 1)
      moves << offset_square(square, 0, 1)
      moves.select { |move| valid_square?(move) }
    end
    
  end

end