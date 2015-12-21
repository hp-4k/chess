module Chess

  RSpec.shared_examples "a piece" do
  
    describe "#new" do
      it "is initialized with :white or :black colour" do
        expect { described_class.new(:white) }.not_to raise_error
        expect { described_class.new(:black) }.not_to raise_error
        expect { described_class.new(:yellow) }.to raise_error ArgumentError
        expect { described_class.new }.to raise_error ArgumentError
      end
    end
  
    describe "#color" do
      it "returns the piece's color" do
        expect(described_class.new(:white).colour).to eq :white
      end
    end
    
    describe "#possible_moves" do
      it "is implemented in a subclass" do
        board_state = {}
        expect { described_class.new(:white).possible_moves("A1", board_state) }.not_to raise_error
      end
    end
    
    # test commented out - offset_square is now private
    #describe "#offset_square(from, columns, rows)" do
    #  it "returns the correct square" do
    #    expect(described_class.new(:white).offset_square("A1", 1, 1)).to eq "B2"
    #    expect(described_class.new(:white).offset_square("A1", 1, 1)).to eq "B2"
    #    expect(described_class.new(:white).offset_square("B3", 5, 3)).to eq "G6"
    #    expect(described_class.new(:white).offset_square("H1", 0, 4)).to eq "H5"
    #    expect(described_class.new(:white).offset_square("B6", 5, 0)).to eq "G6"
    #    expect(described_class.new(:white).offset_square("G7", -3, -4)).to eq "D3"
    # end
    #end
  end

end