require "spec_helper"

describe Karabiner::XmlTree do
  subject do
    Class.new do
      include Karabiner::XmlTree

      def initialize(label); @label = label; end
      def inspect; @label; end
    end
  end

  before do
    @root                         = subject.new("root")
    @root_child_1                 = subject.new("root_child_1")
    @root_child_1_child_1         = subject.new("root_child_1_child_1")
    @root_child_1_child_1_child_1 = subject.new("root_child_1_child_1_child_1")
    @root_child_2                 = subject.new("root_child_2")
    @root_child_3                 = subject.new("root_child_3")

    @root.add_child(@root_child_1)
    @root_child_1.add_child(@root_child_1_child_1)
    @root_child_1_child_1.add_child(@root_child_1_child_1_child_1)

    @root.add_child(@root_child_2)
    @root.add_child(@root_child_3)
  end

  describe "#ancestors" do
    it "returns ancestors of root node" do
      expect(@root.ancestors).to be_empty
    end

    it "returns ancestors of first level node" do
      expect(@root_child_1.ancestors).to eq([
        @root,
      ])
    end

    it "returns ancestors of last level node" do
      expect(@root_child_1_child_1_child_1.ancestors).to eq([
        @root_child_1_child_1,
        @root_child_1,
        @root,
      ])
    end
  end

  describe "#descendants" do
    it "returns descendants of root node" do
      expect(@root.descendants).to eq([
        @root_child_1,
        @root_child_1_child_1,
        @root_child_1_child_1_child_1,
        @root_child_2,
        @root_child_3,
      ])
    end

    it "returns descendants of first level node" do
      expect(@root_child_1.descendants).to eq([
        @root_child_1_child_1,
        @root_child_1_child_1_child_1,
      ])
    end

    it "returns descendants of last level node" do
      expect(@root_child_1_child_1_child_1.descendants).to be_empty
    end
  end
end
