require 'spec_helper'

module Chess
  
  RSpec.describe Game do
    
    before :each do
      @board = double("board")
      allow(@board).to receive(:place_piece)
    end
      
    
    describe "#new" do
      it "takes a board as a single argument" do
        expect { Game.new(@board) }.not_to raise_error
      end
      
      it "places 32 pieces on the board" do
        expect(@board).to receive(:place_piece).exactly(32).times
        Game.new(@board)
      end
      
      context "with board_state: option" do
        it "populates the board in line with given hash" do
          pieces = { "A3" => "black King", "F6" => "white Pawn", "H8" => "white Queen" }
          game = Game.new(Board.new, board_state: pieces)
          expected_output = <<END_STRING
8 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \u2655
7 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
6 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \u2659 \uFF3F \uFF3F
5 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
4 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
3 \u265A \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
2 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
1 \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F \uFF3F
  \uff21 \uff22 \uff23 \uff24 \uff25 \uff26 \uff27 \uff28
END_STRING
          expected_output.encode("utf-8")
          expect { game.board.show_board }.to output(expected_output).to_stdout
        end
      end
      
    end
    
    describe "#current_player" do
      it "has a current player" do
        expect(Game.new(@board)).to respond_to(:current_player)
      end
      it "is white after initialization" do
        expect(Game.new(@board).current_player).to eq :white
      end
    end
    
    describe "#other_player" do
      it "has an other player" do
        expect(Game.new(@board)).to respond_to(:other_player)
      end
      it "is black after initialization" do
        expect(Game.new(@board).other_player).to eq :black
      end
    end
    
  end
  
end