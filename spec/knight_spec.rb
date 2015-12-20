require 'spec_helper'

module Chess
  
  RSpec.describe Knight do
  
    let(:knight) { Knight.new(:white) }
    
    it_behaves_like "a piece"
  
    describe "#valid_moves" do
      it "returns a collection of valid moves" do
        expect(knight.valid_moves("D5").sort).to eq %w{ E7 F6 F4 E3 C3 B4 B6 C7 }.sort
      end
    end
  
  end

end