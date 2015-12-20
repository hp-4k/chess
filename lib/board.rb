module Chess

  class Board
    
    def initialize
      @squares = {}
    end
    
    def place_piece(piece, square)
      check_validity(square)
      squares[square] = piece
    end
    
    def get_square(square)
      check_validity(square)
      squares[square]
    end
    
    private
    
      attr_accessor :squares
      
      def check_validity(square)
        raise InvalidSquareError unless square[0].upcase.between?('A', 'H') && square[1].to_i.between?(1, 8)
      end
    
    class InvalidSquareError < ArgumentError
    end
  
  end
  
end