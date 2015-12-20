module Chess
  
  class Piece
    
    def self.valid_colours
      [:white, :black]
    end
    
    def self.offset_square(from, columns, rows)
      column, row = from[0].upcase, from[1]
      "#{(column.ord + columns).chr}#{row.to_i + rows}"
    end
    
    attr_reader :colour
    
    def initialize(colour)
      raise ArgumentError, "Invalid piece colour" unless Piece.valid_colours.include?(colour)
      @colour = colour
    end
    
    def valid_moves(board, square)
      raise NotImplementedError
    end
    
  end

end