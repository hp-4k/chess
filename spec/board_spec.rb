require 'spec_helper'

module Chess

  RSpec.describe Board do
    
    let(:board) { Board.new }
    
    describe ".offset_square(from, columns, rows)" do
      it "returns the correct square" do
        expect(Board.offset_square("A1", 1, 1)).to eq "B2"
        expect(Board.offset_square("B3", 5, 3)).to eq "G6"
        expect(Board.offset_square("H1", 0, 4)).to eq "H5"
        expect(Board.offset_square("B6", 5, 0)).to eq "G6"
        expect(Board.offset_square("G7", -3, -4)).to eq "D3"
      end
      
      it "returns nil if the new square is outside the board" do
        expect(Board.offset_square("A1", -1, -1)).to be nil
        expect(Board.offset_square("H8", 4, 0)).to be nil
      end
      
      it "raises InvalidSquareError if starting square is not valid" do
        expect { Board.offset_square("I3", -3, -2) }.to raise_error Board::InvalidSquareError
      end
    end
    
    describe "#place_piece(piece, square)" do
      context "when given a valid square" do
        it "puts the piece on the given square" do
          board.place_piece("a piece", "F5")
          expect(board.get_square("F5")).to eq "a piece"
        end
      end
      
      context "when given an invalid square" do
        it "raises InvalidSquareError" do
          expect { board.place_piece("a piece", "I9") }.to raise_error Board::InvalidSquareError
        end
      end
    end
    
    describe "#get_square" do
      context "when given a valid square between A1 and H8" do
        
        context "when there is a piece on the square" do
          it "returns the piece" do
            board.place_piece("a piece", "F3")
            expect(board.get_square("F3")).to eq "a piece"
          end
        end
        
        context "when the square is empty" do
          it "returns nil" do
            expect(board.get_square("H5")).to be nil
          end
        end
        
      end
      
      context "when given an invalid square" do
        it "raises IvalidSquareError" do
          expect { board.get_square("A0") }.to raise_error Board::InvalidSquareError
        end
      end
    end
    
    describe "#show_board" do
      context "with an empty board" do
        
        it "prints the board to standard output" do
          expected_output = <<END_STRING
8 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
7 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
6 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
5 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
4 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
3 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
2 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
1 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
  \uff21 \uff22 \uff23 \uff24 \uff25 \uff26 \uff27 \uff28
END_STRING
          expected_output.encode("utf-8")
          expect { board.show_board }.to output(expected_output).to_stdout
        end
        
        context "with pieces on the board"
        
      end
    end
    
    describe "#white_king_location" do
      it "returns the location of the white king" do
        board.place_piece(King.new(:white), "D5")
        board.place_piece(King.new(:black), "A3")
        expect(board.white_king_location).to eq "D5"
      end
    end
    
    describe "#black_king_location" do
      it "returns the location of the black king" do
        board.place_piece(King.new(:white), "D5")
        board.place_piece(King.new(:black), "A3")
        expect(board.black_king_location).to eq "A3"
      end
    end
    
    describe "#in_check?" do
      it "returns true when a field is in check from N" do
        board.place_piece(Rook.new(:black), "E8")
        expect(board.in_check?("E4", :white)).to be true
      end
      
      it "returns true when a field is in check from NE" do
        board.place_piece(Bishop.new(:white), "H7")
        expect(board.in_check?("E4", :black)).to be true
      end
      
      it "returns true when a field is in check from E" do
        board.place_piece(Rook.new(:white), "H7")
        expect(board.in_check?("B7", :black)).to be true
      end
      
      it "returns true when a field is in check from SE" do
        board.place_piece(Queen.new(:white), "E3")
        expect(board.in_check?("B6", :black)).to be true
      end
      
      it "returns true when a field is in check from S" do
        board.place_piece(King.new(:black), "E3")
        expect(board.in_check?("E4", :white)).to be true
      end
      
      it "returns true when a field is in check from SW" do
        board.place_piece(King.new(:black), "E3")
        expect(board.in_check?("F4", :white)).to be true
      end
      
      it "returns true when a field is in check from W" do
        board.place_piece(Rook.new(:black), "E3")
        expect(board.in_check?("H3", :white)).to be true
      end
      
      it "returns true when a field is in check from NW" do
        board.place_piece(Bishop.new(:black), "E3")
        expect(board.in_check?("G1", :white)).to be true
      end
      
      it "returns true when a field is in check from a knight" do
        board.place_piece(Knight.new(:black), "C3")
        expect(board.in_check?("E4", :white)).to be true
      end
      
      it "returns true when a black piece is in check from a white pawn" do
        board.place_piece(Pawn.new(:white), "C3")
        expect(board.in_check?("D4", :black)).to be true
      end
      
      it "returns true when a white piece is in check from a black pawn" do
        board.place_piece(Pawn.new(:black), "C6")
        expect(board.in_check?("B5", :white)).to be true
      end
      
      it "returns false when a field is not attacked by any pieces" do
        board.place_piece(Bishop.new(:white), "A1")
        board.place_piece(Queen.new(:white), "A2")
        board.place_piece(Knight.new(:white), "G7")
        expect(board.in_check?("B8", :black)).to be false
      end
      
      it "returns false when a field is only attacked by pieces of own colour" do
        board.place_piece(Pawn.new(:white), "C3")
        board.place_piece(Knight.new(:white), "E2")
        board.place_piece(King.new(:white), "C2")
        board.place_piece(Queen.new(:white), "A5")
        board.place_piece(Bishop.new(:white), "A1")
        board.place_piece(Rook.new(:white), "C8")
        expect(board.in_check?("D4", :white)).to be false
      end
      
      it "returns false when vertical line of attack is obscured" do
        board.place_piece(King.new(:white), "E1")
        board.place_piece(Pawn.new(:white), "E2")
        board.place_piece(Queen.new(:black), "E7")
        expect(board.in_check?("E1", :white)).to be false
      end
      
      it "returns false when vertical line of attack is obscured" do
        board.place_piece(King.new(:black), "E8")
        board.place_piece(Pawn.new(:black), "F7")
        board.place_piece(Queen.new(:white), "H5")
        expect(board.in_check?("E8", :black)).to be false
      end
      
      it "returns false when 2 kings are > 1 squares away from each other" do
        board.place_piece(King.new(:white), "E1")
        board.place_piece(King.new(:black), "E8")
        expect(board.in_check?("E1", :white)).to be false
        expect(board.in_check?("E8", :black)).to be false
      end
      
    end
    
  end

end