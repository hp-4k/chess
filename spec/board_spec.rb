require 'spec_helper'

module Chess

  RSpec.describe Board do
    
    let(:board) { Board.new }
    
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
    
  end

end