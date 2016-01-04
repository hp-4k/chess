module Chess
  
  class Game
    
    class PromotionMonitor
      
      def initialize(board)
        @board = board
      end
      
      def check_move(from, to)
        piece = @board.get_square(from)
        if piece.is_a?(Pawn) && to =~ /1|8/
          @board.place_piece(get_piece_from_player(piece), from)
        end
      end
      
      private
      
        def get_piece_from_player(pawn)
          choice = nil
          until %w{ 1 2 3 4 }.include?(choice) do
            puts "Pick a piece:"
            puts "1 => Queen"
            puts "2 => Rook"
            puts "3 => Bishop"
            puts "4 => Knight"
            choice = STDIN.gets.chomp
            puts "Invalid choice! Try again." unless %w{ 1 2 3 4 }.include?(choice)
          end
          
          case choice
          when '1' then Queen.new(pawn.colour)
          when '2' then Rook.new(pawn.colour)
          when '3' then Bishop.new(pawn.colour)
          when '4' then Knight.new(pawn.colour)
          end
          
        end
      
    end
    
  end
  
end