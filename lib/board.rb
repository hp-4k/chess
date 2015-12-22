module Chess

  class Board
    
    def self.valid_square?(square)
      square[0].upcase.between?('A', 'H') && square[1].to_i.between?(1, 8)
    end
    
    def self.offset_square(from, columns, rows)
      raise InvalidSquareError unless valid_square?(from)
      column, row = from[0].upcase, from[1]
      new_square = "#{(column.ord + columns).chr}#{row.to_i + rows}"
      valid_square?(new_square) ? new_square : nil
    end
    
    def initialize
      @squares = {}
    end
    
    def place_piece(piece, square)
      raise InvalidSquareError unless Board.valid_square?(square)
      squares[square] = piece
    end
    
    def get_square(square)
      raise InvalidSquareError unless Board.valid_square?(square)
      squares[square]
    end
    
    def show_board
      8.downto(1) do |row|
        $stdout.print row
        'A'.upto('H') do |col|
          $stdout.print " "
          print_square(col + row.to_s)
        end
        $stdout.print "\n"
      end
      $stdout.puts "  \uff21 \uff22 \uff23 \uff24 \uff25 \uff26 \uff27 \uff28".encode("utf-8")
    end
    
    def state
      squares
    end
    
    def white_king_location
      squares.select { |square, piece| piece.is_a?(King) && piece.colour == :white }.keys.first
    end
    
    def black_king_location
      squares.select { |square, piece| piece.is_a?(King) && piece.colour == :black }.keys.first
    end
    
    private
    
      attr_accessor :squares
      
      def print_square(square)
        $stdout.print(get_square(square) || "\uFF3F".encode("utf-8"))
      end
    
    class InvalidSquareError < ArgumentError
    end
  
  end
  
end