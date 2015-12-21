require 'spec_helper'

module Chess
  
  RSpec.describe Game do
    
    describe "#new" do
      it "takes a board as a single argument" do
        board = double("board")
        allow(board).to receive(:place_piece)
        expect { Game.new(Board.new) }.not_to raise_error
      end
      
      it "places 32 pieces on the board" do
        board = double("board")
        allow(board).to receive(:place_piece)
        expect(board).to receive(:place_piece).exactly(32).times
        Game.new(board)
      end
    end
    
  end
  
end