require 'spec_helper'

module Chess
  
  RSpec.describe Bishop do
  
    let(:bishop) { Bishop.new(:white) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      context "on an empty board" do
        it "returns a collection of valid moves" do
          expect(bishop.possible_moves("B2", {}).sort).to eq %w{ A1 C3 D4 E5 F6 G7 H8 A3 C1 }.sort
        end
      end
      
      context "with other pieces on board" do
        it "returns a collection of valid moves" do
          board_state = {
            "B6" => true,
            "G7" => true,
            "E3" => true
          }
          expect(bishop.possible_moves("D4", board_state).sort).to eq %w{ A1 B2 C3 C5 B6 E5 F6 G7 E3 }.sort
        end
      end
    end
  
  end

end