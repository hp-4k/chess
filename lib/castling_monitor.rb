module Chess
  class Game
    class CastlingMonitor
      
      def initialize(board)
        @board = board
        @possible_castlings = {
          white_short: true,
          white_long: true,
          black_short: true,
          black_long: true
        }
      end
      
      def check_move(from, to)
        moving_piece = @board.get_square(from)
        if moving_piece.is_a?(King) && moving_piece.colour == :white && from == "E1" && to == "G1"
          white_short_castling
        elsif moving_piece.is_a?(King) && moving_piece.colour == :white && from == "E1" && to == "C1"
          white_long_castling
        elsif moving_piece.is_a?(King) && moving_piece.colour == :black && from == "E8" && to == "G8"
          black_short_castling
        elsif moving_piece.is_a?(King) && moving_piece.colour == :black && from == "E8" && to == "C8"
          black_long_castling
        else
          @possible_castlings[:white_short] = false if from == "E1" || from == "H1" || to == "H1"
          @possible_castlings[:white_long] = false if from == "E1" || from == "A1" || to == "A1"
          @possible_castlings[:black_short] = false if from == "E8" || from == "H8" || to == "H8"
          @possible_castlings[:black_long] = false if from == "E8" || from == "A8" || to == "A8"
        end
      end
      
      def white_short_castling_possible
        @possible_castlings[:white_short] &&
        !@board.in_check?("E1", :white) &&
        !@board.in_check?("F1", :white) &&
        !@board.in_check?("G1", :white) &&
        !@board.get_square("F1") &&
        !@board.get_square("G1")
      end
      
      def white_short_castling
        raise Game::InvalidMoveError unless white_short_castling_possible
        piece = @board.get_square("H1")
        @board.place_piece(nil, "H1")
        @board.place_piece(piece, "F1")
      end
      
      def white_long_castling_possible
        @possible_castlings[:white_long] &&
        !@board.in_check?("E1", :white) &&
        !@board.in_check?("D1", :white) &&
        !@board.in_check?("C1", :white) &&
        !@board.get_square("D1") &&
        !@board.get_square("C1")
      end
      
      def white_long_castling
        raise Game::InvalidMoveError unless white_long_castling_possible
        piece = @board.get_square("A1")
        @board.place_piece(nil, "A1")
        @board.place_piece(piece, "D1")
      end
      
      def black_short_castling_possible
        @possible_castlings[:black_short] &&
        !@board.in_check?("E8", :black) &&
        !@board.in_check?("F8", :black) &&
        !@board.in_check?("G8", :black) &&
        !@board.get_square("F8") &&
        !@board.get_square("G8")
      end
      
      def black_short_castling
        raise Game::InvalidMoveError unless black_short_castling_possible
        piece = @board.get_square("H8")
        @board.place_piece(nil, "H8")
        @board.place_piece(piece, "F8")
      end
      
      def black_long_castling_possible
        @possible_castlings[:black_long] &&
        !@board.in_check?("E8", :black) &&
        !@board.in_check?("D8", :black) &&
        !@board.in_check?("C8", :black) &&
        !@board.get_square("D8") &&
        !@board.get_square("C8")
      end
      
      def black_long_castling
        raise Game::InvalidMoveError unless black_long_castling_possible
        piece = @board.get_square("A8")
        @board.place_piece(nil, "A8")
        @board.place_piece(piece, "D8")
      end
    end
  end
end