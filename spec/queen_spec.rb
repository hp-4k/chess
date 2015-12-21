require 'spec_helper'

module Chess
  
  RSpec.describe Queen do
  
    let(:queen) { Queen.new(:white) }
    let(:black_queen) { Queen.new(:black) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      context "on an empty board" do
        it "returns a collection of valid moves" do
          board_state = {}
          expect(queen.possible_moves("C5", board_state).sort).to eq %w{ A5 B5 D5 E5 F5 G5 H5 C1 C2 C3 C4 C6 C7 C8 A7 B6 D4 E3 F2 G1 A3 B4 D6 E7 F8 }.sort
        end
      end
      
      context "on a board with other pieces" do
        it "returns a collection of valid moves" do
          board_state = {
            "A7" => true,
            "C7" => true,
            "E7" => true,
            "F5" => true,
            "B4" => true,
            "C2" => true
          }
          expect(queen.possible_moves("C5", board_state).sort).to eq %w{ A5 B5 D5 E5 F5 C2 C3 C4 C6 C7 B4 D6 E7 A7 B6 D4 E3 F2 G1 }.sort
        end
      end
    end
    
    describe "#to_s" do
      it "prints a correct unicode character" do
        expect(queen.to_s).to eq "\u2655".encode("utf-8")
        expect(black_queen.to_s).to eq "\u265B".encode("utf-8")
      end
    end
    
  end

end