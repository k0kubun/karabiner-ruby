require "spec_helper"

describe Dotremap::Key do
  describe "#to_s" do
    EXPECTED_RESULTS = {
      "a" => "KeyCode::A",
      "b" => "KeyCode::B",
      "c" => "KeyCode::C",
      "d" => "KeyCode::D",
      "e" => "KeyCode::E",
      "f" => "KeyCode::F",
      "g" => "KeyCode::G",
      "h" => "KeyCode::H",
      "i" => "KeyCode::I",
      "j" => "KeyCode::J",
      "k" => "KeyCode::K",
      "l" => "KeyCode::L",
      "m" => "KeyCode::M",
      "n" => "KeyCode::N",
      "o" => "KeyCode::O",
      "p" => "KeyCode::P",
      "q" => "KeyCode::Q",
      "r" => "KeyCode::R",
      "s" => "KeyCode::S",
      "t" => "KeyCode::T",
      "u" => "KeyCode::U",
      "v" => "KeyCode::V",
      "w" => "KeyCode::W",
      "x" => "KeyCode::X",
      "y" => "KeyCode::Y",
      "z" => "KeyCode::Z",
    }.freeze

    it "converts key expression as expected" do
      EXPECTED_RESULTS.each do |expression, result|
        expect(described_class.new(expression).to_s).to eq(result)
      end
    end
  end
end
