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
        
        it "carries out white short castling" do
          pieces = {
            "E1" => "white King",
            "A1" => "white Rook",
            "H1" => "white Rook",
            "E8" => "black King",
            "A8" => "black Rook",
            "H8" => "black Rook"
          }
          game = Game.new(Board.new, board_state: pieces)
          expect { game.move("E1", "G1") }.not_to raise_error
          expect(game.board.get_square("E1")).to be nil
          expect(game.board.get_square("F1")).to be_a Rook
          expect(game.board.get_square("G1")).to be_a King
          expect(game.board.get_square("H1")).to be nil
        end
        
        it "carries out white long castling" do
          pieces = {
            "E1" => "white King",
            "A1" => "white Rook",
            "H1" => "white Rook",
            "E8" => "black King",
            "A8" => "black Rook",
            "H8" => "black Rook"
          }
          game = Game.new(Board.new, board_state: pieces)
          expect { game.move("E1", "C1") }.not_to raise_error
          expect(game.board.get_square("E1")).to be nil
          expect(game.board.get_square("D1")).to be_a Rook
          expect(game.board.get_square("C1")).to be_a King
          expect(game.board.get_square("A1")).to be nil
        end
        
        it "carries out black short castling" do
          pieces = {
            "E1" => "white King",
            "A1" => "white Rook",
            "H1" => "white Rook",
            "E8" => "black King",
            "A8" => "black Rook",
            "H8" => "black Rook"
          }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          expect { game.move("E8", "G8") }.not_to raise_error
          expect(game.board.get_square("E8")).to be nil
          expect(game.board.get_square("F8")).to be_a Rook
          expect(game.board.get_square("G8")).to be_a King
          expect(game.board.get_square("H8")).to be nil
        end
        
        it "carries out black long castling" do
          pieces = {
            "E1" => "white King",
            "A1" => "white Rook",
            "H1" => "white Rook",
            "E8" => "black King",
            "A8" => "black Rook",
            "H8" => "black Rook"
          }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          expect { game.move("E8", "C8") }.not_to raise_error
          expect(game.board.get_square("E8")).to be nil
          expect(game.board.get_square("D8")).to be_a Rook
          expect(game.board.get_square("C8")).to be_a King
          expect(game.board.get_square("A8")).to be nil
        end
        
        it "carries out en passant with a white pawn" do
          pieces = {
            "E5" => "white Pawn",
            "F7" => "black Pawn",
            "E1" => "white King",
            "E8" => "black King"
          }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          game.move("F7", "F5")
          expect { game.move("E5", "F6") }.not_to raise_error
          expect(game.board.get_square("F5")).to be nil
          expect(game.board.get_square("F6")).to be_a Pawn
        end
        
        it "carries out en passant with a black pawn" do
          pieces = {
            "E2" => "white Pawn",
            "F4" => "black Pawn",
            "E1" => "white King",
            "E8" => "black King"
          }
          game = Game.new(Board.new, board_state: pieces)
          game.move("E2", "E4")
          expect { game.move("F4", "E3") }.not_to raise_error
          expect(game.board.get_square("E4")).to be nil
          expect(game.board.get_square("E3")).to be_a Pawn
        end
        
        context "when a pawn reaches last row" do
          
          it "prompts the player to pick a piece" do
            pieces = {
              "A7" => "white Pawn",
              "A1" => "white King",
              "D7" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces)
            allow(STDIN).to receive(:gets).and_return('1') # 1 => Queen
            expect { game.move("A7", "A8") }.to output(/Pick a piece/).to_stdout
          end
          
          it "replaces a white pawn with a white piece of player's choice" do
            pieces = {
              "A7" => "white Pawn",
              "A1" => "white King",
              "D7" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces)
            allow(STDOUT).to receive(:write) # supresses stdout
            allow(STDIN).to receive(:gets).and_return('1') # 1 => Queen
            game.move("A7", "A8")
            expect(game.board.get_square("A8")).to be_a Queen
            expect(game.board.get_square("A8").colour).to eq :white
          end
          
          it "replaces a black pawn with a black piece of player's choice" do
            pieces = {
              "D2" => "black Pawn",
              "A1" => "white King",
              "D7" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces, black_starts: true)
            allow(STDOUT).to receive(:write) # supresses stdout
            allow(STDIN).to receive(:gets).and_return('4') # 4 => Knight
            game.move("D2", "D1")
            expect(game.board.get_square("D1")).to be_a Knight
            expect(game.board.get_square("D1").colour).to eq :black
          end
          
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
        
        context "throws InvalidMoveError for invalid castling" do
          
          it "when king is in check" do
            pieces = {
              "E1" => "white King",
              "H1" => "white Rook",
              "E8" => "black King",
              "E7" => "black Queen"
            }
            game = Game.new(Board.new, board_state: pieces)
            expect { game.move("E1", "G1") }.to raise_error Game::InvalidMoveError
          end
          
          it "when king passes through a square in check" do
            pieces = {
              "E1" => "white King",
              "H1" => "white Rook",
              "E8" => "black King",
              "F7" => "black Queen"
            }
            game = Game.new(Board.new, board_state: pieces)
            expect { game.move("E1", "G1") }.to raise_error Game::InvalidMoveError
          end
          
          it "when king has moved before" do
            pieces = {
              "E1" => "white King",
              "H1" => "white Rook",
              "E8" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces)
            game.move("E1", "D1")
            game.move("E8", "D8")
            game.move("D1", "E1")
            game.move("D8", "C8")
            expect { game.move("E1", "G1") }.to raise_error Game::InvalidMoveError
          end
          
          it "when rook has moved before" do
            pieces = {
              "E1" => "white King",
              "H1" => "white Rook",
              "E8" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces)
            game.move("H1", "H7")
            game.move("E8", "D8")
            game.move("H7", "H1")
            game.move("D8", "C8")
            expect { game.move("E1", "G1") }.to raise_error Game::InvalidMoveError
          end
          
          it "when there is a piece in between" do
            pieces = {
              "E1" => "white King",
              "H1" => "white Rook",
              "F1" => "white Knight",
              "E8" => "black King"
            }
            game = Game.new(Board.new, board_state: pieces)
            expect { game.move("E1", "G1") }.to raise_error Game::InvalidMoveError
          end
          
        end
        
        it "throws InvalidMoveError for an invalid en passant attempt" do
          pieces = {
            "E1" => "white King",
            "E8" => "black King",
            "B5" => "white Pawn",
            "C6" => "black Pawn"
          }
          game = Game.new(Board.new, board_state: pieces, black_starts: true)
          game.move("C6", "C5")
          expect { game.move("B5", "C6") }.to raise_error Game::InvalidMoveError
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
      
      it "returns false when check on board but attacking piece can be obscured" do
        pieces = {
          "F1" => "white King",
          "H7" => "white Rook",
          "F8" => "black Queen",
          "G3" => "black King"
        }
        game = Game.new(Board.new, board_state: pieces, black_starts: true) # black starts to simulate that black player has just moved
        expect(game.check_mate?).to be false
      end
      
      it "does not consider pawn promotion when looking for possible ways to get out of check" do
        pieces = {
          "C7" => "white Pawn",
          "A8" => "white King",
          "H8" => "black King",
          "G8" => "black Queen"
        }
        game = Game.new(Board.new, board_state: pieces, black_starts: true)
        allow(STDIN).to receive(:gets).and_return('1')
        expect { game.check_mate? }.not_to output.to_stdout
      end
      
      it "returns :stalemate when white player is in stalemate" do
        pieces = {
          "A3" => "white Pawn",
          "B4" => "white Pawn",
          "A4" => "black Pawn",
          "B5" => "black Pawn",
          "H1" => "white King",
          "H8" => "black King",
          "F2" => "black Queen"
        }
        game = Game.new(Board.new, board_state: pieces)
        expect(game.check_mate?).to eq :stalemate
      end
      
      it "returns :stalemate when black player is in stalemate" do
        pieces = {
          "A3" => "white Pawn",
          "B4" => "white Pawn",
          "A4" => "black Pawn",
          "B5" => "black Pawn",
          "H1" => "white King",
          "H8" => "black King",
          "G1" => "white Rook",
          "F5" => "white Bishop"
        }
        game = Game.new(Board.new, board_state: pieces, black_starts: true)
        expect(game.check_mate?).to eq :stalemate
      end
      
    end
  end
end