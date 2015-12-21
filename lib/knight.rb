module Chess

  class Knight < Piece
    
    def possible_moves(square, board_state)
      moves = []
      moves << offset_square(square, 1, 2)
      moves << offset_square(square, 2, 1)
      moves << offset_square(square, 2, -1)
      moves << offset_square(square, 1, -2)
      moves << offset_square(square, -1, -2)
      moves << offset_square(square, -2, -1)
      moves << offset_square(square, -2, 1)
      moves << offset_square(square, -1, 2)
      moves.select { |move| valid_square?(move) }
    end
    
    private
    
      def white_symbol
        "\u2658"
      end
      
      def black_symbol
         "\u265E"
      end
    
  end

end