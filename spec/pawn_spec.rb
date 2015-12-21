require 'spec_helper'

module Chess
  
  RSpec.describe Pawn do
  
    let(:white_pawn) { Pawn.new(:white) }
    let(:black_pawn) { Pawn.new(:black) }
    
    it_behaves_like "a piece"
  
    describe "#possible_moves" do
      
      context "for white pawns" do
        context "without pieces to capture" do
          it "returns correct moves for pawns in row #2" do
            board_state= {}
            expect(white_pawn.possible_moves("F2", board_state).sort).to eq %w{ F3 F4 }.sort
          end
          
          it "return correct moves for pawns in other rows" do
            board_state = {}
            expect(white_pawn.possible_moves("B4", board_state).sort).to eq %w{ B5 }.sort
          end
        end
        
        context "with pieces to capture" do
          it "returns correct moves for pawns in row #2" do
            board_state= {
              "B3" => true,
              "C4" => true
            }
            expect(white_pawn.possible_moves("C2", board_state).sort).to eq %w{ C3 B3 }.sort
          end
          
          it "return correct moves for pawns in other rows" do
            board_state = {
              "F6" => true,
              "E6" => true,
              "G6" => true,
              "E4" => true
            }
            expect(white_pawn.possible_moves("F5", board_state).sort).to eq %w{ E6 G6 }.sort
          end
        end
      end
      
      context "for black pawns" do
        context "without pieces to capture" do
          it "returns correct moves for pawns in row #7" do
            board_state= {}
            expect(black_pawn.possible_moves("F7", board_state).sort).to eq %w{ F6 F5 }.sort
          end
          
          it "return correct moves for pawns in other rows" do
            board_state= {}
            expect(black_pawn.possible_moves("E2", board_state).sort).to eq %w{ E1 }.sort
          end
        end
        
        context "with pieces to capture" do
          it "returns correct moves for pawns in row #7" do
            board_state= {
              "F6" => true,
              "E5" => true
            }
            expect(black_pawn.possible_moves("E7", board_state).sort).to eq %w{ F6 E6 }.sort
          end
          
          it "return correct moves for pawns in other rows" do
            board_state= {
              "F5" => true,
              "E5" => true,
              "D5" => true
            }
            expect(black_pawn.possible_moves("E6", board_state).sort).to eq %w{ F5 D5 }.sort
          end
        end
      end
    end
  
  end

end