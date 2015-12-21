module Chess
  
  class Piece
    
    def self.valid_colours
      [:white, :black]
    end
    
    attr_reader :colour
    
    def initialize(colour)
      raise ArgumentError, "Invalid piece colour" unless Piece.valid_colours.include?(colour)
      @colour = colour
    end
    
    def valid_moves(board, square)
      raise NotImplementedError
    end
    
    private
    
      def valid_square?(square)
        square[0].upcase.between?('A', 'H') && square[1].to_i.between?(1, 8)
      end
    
      def offset_square(from, columns, rows)
        column, row = from[0].upcase, from[1]
        "#{(column.ord + columns).chr}#{row.to_i + rows}"
      end
      
  end

end