module Chess

  class Pawn < Piece
    
    def possible_moves(square, board_state)
      moves = []
      if colour == :white
        find_white_moves(square, board_state, moves)
      else
        find_black_moves(square, board_state, moves)
      end
      moves.select { |move| valid_square?(move) }
    end
    
    private
      
      def find_white_moves(square, board_state, moves)
        moves << offset_square(square, 0, 1) unless board_state[offset_square(square, 0, 1)]
        moves << offset_square(square, 0, 2) unless board_state[offset_square(square, 0, 2)] if square =~ /2/
        moves << offset_square(square, 1, 1) # if board_state[offset_square(square, 1, 1)]
        moves << offset_square(square, -1, 1) # if board_state[offset_square(square, -1, 1)]
      end
      
      def find_black_moves(square, board_state, moves)
        moves << offset_square(square, 0, -1) unless board_state[offset_square(square, 0, -1)]
        moves << offset_square(square, 0, -2) unless board_state[offset_square(square, 0, -2)] if square =~ /7/
        moves << offset_square(square, 1, -1) # if board_state[offset_square(square, 1, -1)]
        moves << offset_square(square, -1, -1) # if board_state[offset_square(square, -1, -1)]
      end
      
      def white_symbol
        "\u2659"
      end
      
      def black_symbol
         "\u265F"
      end
  end
end