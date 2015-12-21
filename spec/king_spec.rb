require 'spec_helper'

module Chess
  
  RSpec.describe King do
  
    let(:king) { King.new(:white) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      context "in the middle of the board" do
        it "returns a collection of possible moves" do
          expect(king.possible_moves("D5", {}).sort).to eq %w{ C6 D6 E6 E5 E4 D4 C4 C5 }.sort
        end
      end
      
      context "at the edge of the board" do
        it "returns a collection of possible moves" do
          expect(king.possible_moves("A3", {}).sort).to eq %w{ A2 B2 B3 B4 A4 }.sort
        end
      end
    end
  
  end

end