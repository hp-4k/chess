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
    
    def in_check?(square, piece_colour)
      return true if in_check_n?(square, piece_colour)
      return true if in_check_s?(square, piece_colour)
      return true if in_check_w?(square, piece_colour)
      return true if in_check_e?(square, piece_colour)
      return true if in_check_ne?(square, piece_colour)
      return true if in_check_se?(square, piece_colour)
      return true if in_check_sw?(square, piece_colour)
      return true if in_check_nw?(square, piece_colour)
      return true if in_check_from_knight?(square, piece_colour)
      return true if in_check_from_pawn?(square, piece_colour)
      return true if in_check_from_king?(square, piece_colour)
      false
    end
    
    private
    
      attr_accessor :squares
      
      def print_square(square)
        $stdout.print(get_square(square) || "\uFF3F".encode("utf-8"))
      end
    
      def in_check_n?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, 0, 1)
        return true if [Rook, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_n?(next_square, piece_colour)
      end
      
      def in_check_s?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, 0, -1)
        return true if [Rook, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_s?(next_square, piece_colour)
      end
      
      def in_check_w?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, -1, 0)
        return true if [Rook, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_w?(next_square, piece_colour)
      end
      
      def in_check_e?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, 1, 0)
        return true if [Rook, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_e?(next_square, piece_colour)
      end
      
      def in_check_ne?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, 1, 1)
        return true if [Bishop, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_ne?(next_square, piece_colour)
      end
      
      def in_check_se?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, 1, -1)
        return true if [Bishop, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_se?(next_square, piece_colour)
      end
      
      def in_check_sw?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, -1, -1)
        return true if [Bishop, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_sw?(next_square, piece_colour)
      end
      
      def in_check_nw?(square, piece_colour)
        return false unless next_square = self.class.offset_square(square, -1, 1)
        return true if [Bishop, Queen].include?(squares[next_square].class) &&
          squares[next_square].colour != piece_colour
        return false if squares[next_square]
        in_check_nw?(next_square, piece_colour)
      end
      
      def in_check_from_knight?(square, piece_colour)
        squares_to_check = Knight.new(:white).possible_moves(square, squares)
        squares_to_check.any? { |square| squares[square].is_a?(Knight) && squares[square].colour != piece_colour }
      end
      
      def in_check_from_pawn?(square, piece_colour)
        if piece_colour == :white
          squares_to_check = [self.class.offset_square(square, 1,1), self.class.offset_square(square, -1,1)]
        else
          squares_to_check = [self.class.offset_square(square, 1,-1), self.class.offset_square(square, -1,-1)]
        end
        squares_to_check.any? { |square| squares[square].is_a?(Pawn) && squares[square].colour != piece_colour }
      end
      
      def in_check_from_king?(square, piece_colour)
        squares_to_check = King.new(:white).possible_moves(square, squares)
        squares_to_check.any? { |square| squares[square].is_a?(King) && squares[square].colour != piece_colour }
      end
    
    class InvalidSquareError < ArgumentError
    end
  
  end
  
end