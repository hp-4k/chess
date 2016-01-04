require 'spec_helper'

module Chess
  
  RSpec.describe King do
  
    let(:king) { King.new(:white) }
    let(:black_king) { King.new(:black) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      context "in the middle of the board" do
        it "returns a collection of possible moves" do
          expect(king.possible_moves("D5", {}).sort).to eq %w{ C6 D6 E6 E5 E4 D4 C4 C5 F5 B5 }.sort
        end
      end
      
      context "at the edge of the board" do
        it "returns a collection of possible moves" do
          expect(king.possible_moves("A3", {}).sort).to eq %w{ A2 B2 B3 B4 A4 C3 }.sort
        end
      end
    end
    
    describe "#to_s" do
      it "prints a correct unicode character" do
        expect(king.to_s).to eq "\u2654".encode("utf-8")
        expect(black_king.to_s).to eq "\u265A".encode("utf-8")
      end
    end
    
  end

end