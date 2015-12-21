module Chess

  class Bishop < Piece
    
    def possible_moves(square, board_state)
      moves = []
      
      detect_possible_ne_moves(square, board_state, moves)
      detect_possible_se_moves(square, board_state, moves)
      detect_possible_sw_moves(square, board_state, moves)
      detect_possible_nw_moves(square, board_state, moves)
      
      moves
    end
    
    private
    
      def detect_possible_ne_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, i, i))
          moves << offset_square(square, i, i)
          break if board_state[offset_square(square, i, i)]
          i += 1
        end
      end
      
      def detect_possible_se_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, i, -i))
          moves << offset_square(square, i, -i)
          break if board_state[offset_square(square, i, -i)]
          i += 1
        end
      end
      
      def detect_possible_sw_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, -i, -i))
          moves << offset_square(square, -i, -i)
          break if board_state[offset_square(square, -i, -i)]
          i += 1
        end
      end
      
      def detect_possible_nw_moves(square, board_state, moves)
        i = 1
        while valid_square?(offset_square(square, -i, i))
          moves << offset_square(square, -i, i)
          break if board_state[offset_square(square, -i, i)]
          i += 1
        end
      end
     
      def white_symbol
        "\u2657"
      end
      
      def black_symbol
         "\u265D"
      end
  end

end