module Chess

  class Rook < Piece
    
    def possible_moves(square, board_state)
      moves = []
      
      detect_possible_n_moves(square, board_state, moves)
      detect_possible_s_moves(square, board_state, moves)
      detect_possible_w_moves(square, board_state, moves)
      detect_possible_e_moves(square, board_state, moves)
      
      moves
    end
    
    private
    
      def detect_possible_n_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, i, 0))
          moves << offset_square(square, i, 0)
          break if board_state[offset_square(square, i, 0)]
          i += 1
        end
      end
      
      def detect_possible_s_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, -i, 0))
          moves << offset_square(square, -i, 0)
          break if board_state[offset_square(square, -i, 0)]
          i += 1
        end
      end
      
      def detect_possible_w_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, 0, i))
          moves << offset_square(square, 0, i)
          break if board_state[offset_square(square, 0, i)]
          i += 1
        end
      end
      
      def detect_possible_e_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, 0, -i))
          moves << offset_square(square, 0, -i)
          break if board_state[offset_square(square, 0, -i)]
          i += 1
        end
      end
      
      def white_symbol
        "\u2656"
      end
      
      def black_symbol
         "\u265C"
      end
  end

end