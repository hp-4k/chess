require 'spec_helper'

module Chess

  RSpec.describe Piece do
    
    describe ".offset_square(from, columns, rows)" do
      it "returns the correct square" do
        expect(Piece.offset_square("A1", 1, 1)).to eq "B2"
        expect(Piece.offset_square("B3", 5, 3)).to eq "G6"
        expect(Piece.offset_square("H1", 0, 4)).to eq "H5"
        expect(Piece.offset_square("B6", 5, 0)).to eq "G6"
        expect(Piece.offset_square("G7", -3, -4)).to eq "D3"
      end
        
    end
  end

end