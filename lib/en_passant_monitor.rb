module Chess

  class Game
  
    class EnPassantMonitor
      
      def initialize(board)
        @board = board
      end
      
      def check_move(from, to)
        if @board.get_square(from).is_a?(Pawn) 
          raise InvalidMoveError unless to[0] == from[0] || @board.get_square(to) || to == @possible_en_passant
          
          if to == @possible_en_passant
            @board.place_piece(nil, @possible_en_passant[1] == "3" ? @possible_en_passant[0] + "4" : @possible_en_passant[0] + "5")
            @possible_en_passant = nil
          elsif from =~ /[A-H]2/ && to =~ /[A-H]4/
            @possible_en_passant = from[0] + "3"
          elsif from =~ /[A-H]7/ && to =~ /[A-H]5/
            @possible_en_passant = from[0] + "6"
          end
        else
          @possible_en_passant = nil
        end
      end
      
    end
  
  end

end