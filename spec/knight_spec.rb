require 'spec_helper'

module Chess
  
  RSpec.describe Knight do
  
    let(:knight) { Knight.new(:white) }
    let(:black_knight) { Knight.new(:black) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      it "returns a collection of valid moves from the middle of the board" do
        board_state = {}
        expect(knight.possible_moves("D5", board_state).sort).to eq %w{ E7 F6 F4 E3 C3 B4 B6 C7 }.sort
      end
      
      it "returns a collection of valid moves from the edge of the board" do
        board_state = {}
        expect(knight.possible_moves("B2", board_state).sort).to eq %w{ A4 C4 D3 D1 }.sort
      end
    end
    
    describe "#to_s" do
      it "prints a correct unicode character" do
        expect(knight.to_s).to eq "\u2658".encode("utf-8")
        expect(black_knight.to_s).to eq "\u265E".encode("utf-8")
      end
    end
  
  end

end