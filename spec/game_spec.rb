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
    
    describe "#move" do
      context "when move is valid" do
        it "moves a piece to target square" do
          pieces = { "A3" => "white Knight" }
          game = Game.new(Board.new, board_state: pieces)
          game.move("A3", "B5")
          expect(game.board.get_square("A3")).to be nil
          expect(game.board.get_square("B5")).not_to be nil
        end
        
        it "captures enemy's piece on the target square" do
          pieces = { "D4" => "black Pawn", "E3" => "white Bishop" }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          game.move("D4", "E3")
          expect(game.board.get_square("D4")).to be nil
          expect(game.board.get_square("E3").colour).to eq :black
        end
        
        it "swaps the current player" do
          game = Game.new(Board.new)
          game.move("E2", "E4")
          expect(game.current_player).to eq :black
          game.move("E7", "E5")
          expect(game.current_player).to eq :white
        end
        
        it "does not throw an error when the move gets the king out of check by moving to a safe square" do
          pieces = {
            "D4" => "white King",
            "H4" => "black Queen",
            "D6" => "white Knight"
          }
          game = Game.new(Board.new, board_state: pieces)
          expect { game.move("D4", "D3") }.not_to raise_error
        end
        
        it "does not throw an error when the move gets the king out of check by obsuring the attacker" do
          pieces = {
            "D4" => "white King",
            "H4" => "black Queen",
            "D6" => "white Knight"
          }
          game = Game.new(Board.new, board_state: pieces)
          expect { game.move("D6", "E4") }.not_to raise_error
        end
      end
      
      context "when move is invalid" do
        it "throws InvalidMoveError when starting square is empty" do
          game = Game.new(Board.new)
          expect { game.move("C3", "C4") }.to raise_error Game::InvalidMoveError
        end
        
        it "throws InvalidSquareError when attempting to move opponent's piece" do
          game = Game.new(Board.new)
          expect { game.move("B8", "C6") }.to raise_error Game::InvalidMoveError
        end
        
        it "throws InvalidMoveError when target square is off the board" do
          game = Game.new(Board.new)
          expect { game.move("A1", "A0") }.to raise_error Game::InvalidMoveError
        end
        
        
        it "throws InvalidMoveError when target square can't be reached" do
          game = Game.new(Board.new)
          expect { game.move("A1", "A3") }.to raise_error Game::InvalidMoveError
          expect { game.move("B1", "C4") }.to raise_error Game::InvalidMoveError
          expect { game.move("C1", "A3") }.to raise_error Game::InvalidMoveError
        end
        
        it "throws InvalidMoveError when attempting to capture own piece" do
          game = Game.new(Board.new)
          expect { game.move("A1", "A2") }.to raise_error Game::InvalidMoveError
        end
        
        it "throws InvalidMoveError when active player's king remains in check" do
          pieces = {
            "G3" => "white King",
            "G7" => "white Rook",
            "D7" => "black King"
          }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          expect { game.move("D7", "C7") }.to raise_error Game::InvalidMoveError  
        end
        
      end
    end
    
    describe "#check_mate?" do
      it "returns :black when black player is in check mate" do
        game = Game.new(Board.new)
        game.move("E2", "E4")
        game.move("E7", "E5")
        game.move("D1", "H5")
        game.move("B8", "C6")
        game.move("F1", "C4")
        game.move("G8", "F6")
        game.move("H5", "F7")
        expect(game.check_mate?).to eq :black
      end
      
      it "returns :white when white player is in check mate" do
        pieces = {
          "F2" => "black Queen",
          "G3" => "black King",
          "F1" => "white King"
        }
        game = Game.new(Board.new, board_state: pieces)
        expect(game.check_mate?).to eq :white
      end
      
      it "returns false when no check mate on the board" do
        pieces = {
          "F2" => "white King",
          "B2" => "black King"
        }
        game = Game.new(Board.new, board_state: pieces)
        expect(game.check_mate?).to be false
      end
      
      it "returns false when check on board but king can move to a safe square" do
        pieces = {
          "A2" => "white King",
          "F2" => "black Queen",
          "G2" => "black King"
        }
        game = Game.new(Board.new, board_state: pieces, black_starts: true) # black starts to simulate that black player has just moved
        expect(game.check_mate?).to be false
      end
      
      it "returns false when check on board but attacking piece can be taken" do
        pieces = {
          "F1" => "white King",
          "F8" => "white Rook",
          "F2" => "black Queen",
          "G3" => "black King"
        }
        game = Game.new(Board.new, board_state: pieces, black_starts: true) # black starts to simulate that black player has just moved
        expect(game.check_mate?).to be false
      end
      
    end
  end
end