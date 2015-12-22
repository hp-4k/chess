require_relative "board.rb"
require_relative "piece.rb"
require_relative "pawn.rb"
require_relative "knight.rb"
require_relative "bishop.rb"
require_relative "rook.rb"
require_relative "queen.rb"
require_relative "king.rb"


module Chess

  class Game
    
    attr_reader :board, :current_player, :other_player
    
    def initialize(board, options = {})
      @board = board
      @current_player = :white
      @other_player = :black
      set_up_board(options[:board_state])
    end
    
    #def 
    
    private
    
      def set_up_board(board_state)
        board_state ? add_pieces_to_board(board_state) : default_set_up
      end
      
      def default_set_up
        # white pieces
        'A'.upto('H') { |col| board.place_piece(Pawn.new(:white), col + '2') }
        board.place_piece(Rook.new(:white), "A1")
        board.place_piece(Knight.new(:white), "B1")
        board.place_piece(Bishop.new(:white), "C1")
        board.place_piece(Queen.new(:white), "D1")
        board.place_piece(King.new(:white), "E1")
        board.place_piece(Bishop.new(:white), "F1")
        board.place_piece(Knight.new(:white), "G1")
        board.place_piece(Rook.new(:white), "H1")
        # black pieces
        'A'.upto('H') { |col| board.place_piece(Pawn.new(:black), col + '7') }
        board.place_piece(Rook.new(:black), "A8")
        board.place_piece(Knight.new(:black), "B8")
        board.place_piece(Bishop.new(:black), "C8")
        board.place_piece(Queen.new(:black), "D8")
        board.place_piece(King.new(:black), "E8")
        board.place_piece(Bishop.new(:black), "F8")
        board.place_piece(Knight.new(:black), "G8")
        board.place_piece(Rook.new(:black), "H8")
      end
      
      def add_pieces_to_board(board_state)
        board_state.each do |square, piece|
          piece_colour, piece_class = piece.split
          board.place_piece(find_class(piece_class).new(piece_colour.to_sym), square)
        end
      end
      
      def find_class(piece_class)
        module_name = self.class.name.split("::").first + "::"
        Object.const_get(module_name + piece_class)
      end
    
  end

end