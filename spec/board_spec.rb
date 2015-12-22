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
    
  end

end