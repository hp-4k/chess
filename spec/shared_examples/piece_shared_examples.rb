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
        expect { described_class.new(:white).possible_moves("A1") }.not_to raise_error
      end
    end
  
  end

end