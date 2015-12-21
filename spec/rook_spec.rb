require 'spec_helper'

module Chess
  
  RSpec.describe Rook do
  
    let(:rook) { Rook.new(:white) }
    let(:black_rook) { Rook.new(:black) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      context "on an empty board" do
        it "returns a collection of valid moves" do
          board_state = {}
          expect(rook.possible_moves("C2", board_state).sort).to eq %w{ A2 B2 C1 C3 C4 C5 C6 C7 C8 D2 E2 F2 G2 H2 }.sort
        end
      end
      
      context "on a board with other pieces" do
        it "returns a collection of valid moves" do
          board_state = {
            "D3" => true,
            "H2" => true
          }
          expect(rook.possible_moves("H3", board_state).sort).to eq %w{ D3 E3 F3 G3 H2 H4 H5 H6 H7 H8 }.sort
        end
      end
    end
    
    describe "#to_s" do
      it "prints a correct unicode character" do
        expect(rook.to_s).to eq "\u2656".encode("utf-8")
        expect(black_rook.to_s).to eq "\u265C".encode("utf-8")
      end
    end
    
  end

end