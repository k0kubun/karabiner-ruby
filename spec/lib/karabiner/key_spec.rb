require "spec_helper"

describe Karabiner::Key do
  describe ".normalize_input" do
    it { expect(described_class.normalize_input('Cmd+Volume Up')).to eq('CMD-VOLUME_UP') }
  end

  describe "#to_s" do
    EXPECTED_RESULTS = {
      "A"       => "KeyCode::A",
      "B"       => "KeyCode::B",
      "C"       => "KeyCode::C",
      "D"       => "KeyCode::D",
      "E"       => "KeyCode::E",
      "F"       => "KeyCode::F",
      "G"       => "KeyCode::G",
      "H"       => "KeyCode::H",
      "I"       => "KeyCode::I",
      "J"       => "KeyCode::J",
      "K"       => "KeyCode::K",
      "L"       => "KeyCode::L",
      "M"       => "KeyCode::M",
      "N"       => "KeyCode::N",
      "O"       => "KeyCode::O",
      "P"       => "KeyCode::P",
      "Q"       => "KeyCode::Q",
      "R"       => "KeyCode::R",
      "S"       => "KeyCode::S",
      "T"       => "KeyCode::T",
      "U"       => "KeyCode::U",
      "V"       => "KeyCode::V",
      "W"       => "KeyCode::W",
      "X"       => "KeyCode::X",
      "Y"       => "KeyCode::Y",
      "Z"       => "KeyCode::Z",
      "0"       => "KeyCode::KEY_0",
      "1"       => "KeyCode::KEY_1",
      "2"       => "KeyCode::KEY_2",
      "3"       => "KeyCode::KEY_3",
      "4"       => "KeyCode::KEY_4",
      "5"       => "KeyCode::KEY_5",
      "6"       => "KeyCode::KEY_6",
      "7"       => "KeyCode::KEY_7",
      "8"       => "KeyCode::KEY_8",
      "9"       => "KeyCode::KEY_9",
      "Up"      => "KeyCode::CURSOR_UP",
      "Down"    => "KeyCode::CURSOR_DOWN",
      "Right"   => "KeyCode::CURSOR_RIGHT",
      "Left"    => "KeyCode::CURSOR_LEFT",
      "]"       => "KeyCode::BRACKET_RIGHT",
      "["       => "KeyCode::BRACKET_LEFT",
      ";"       => "KeyCode::SEMICOLON",
      "-"       => "KeyCode::MINUS",
      ","       => "KeyCode::COMMA",
      "."       => "KeyCode::DOT",
      "\\"      => "KeyCode::BACKSLASH",
      "/"       => "KeyCode::SLASH",
      "="       => "KeyCode::EQUAL",
      "'"       => "KeyCode::QUOTE",
      "`"       => "KeyCode::BACKQUOTE",
      "Ctrl_R"  => "KeyCode::CONTROL_R",
      "Ctrl_L"  => "KeyCode::CONTROL_L",
      "Alt_R"   => "KeyCode::OPTION_R",
      "Alt_L"   => "KeyCode::OPTION_L",
      "Opt_R"   => "KeyCode::OPTION_R",
      "Opt_L"   => "KeyCode::OPTION_L",
      "Cmd_R"   => "KeyCode::COMMAND_R",
      "Cmd_L"   => "KeyCode::COMMAND_L",
      "Esc"     => "KeyCode::ESCAPE",
    }.freeze

    it "converts single key expression as expected" do
      EXPECTED_RESULTS.each do |expression, result|
        expect(described_class.new(expression).to_s).to eq(result)
      end
    end

    it "converts double key combination as expected" do
      Karabiner::Key::PREFIX_MAP.each do |prefix, vk|
        key, keycode = EXPECTED_RESULTS.to_a.sample
        expect(described_class.new("#{prefix}-#{key}").to_s).to eq("#{keycode}, #{vk}")
      end
    end

    it "converts triple key combination as expected" do
      key, keycode = EXPECTED_RESULTS.to_a.sample
      unique_maps = Karabiner::Key::PREFIX_MAP.to_a.sort_by { rand }.uniq { |a| a[1] }
      unique_maps.combination(2) do |(prefix1, vk1), (prefix2, vk2)|
        expect(described_class.new("#{prefix1}-#{prefix2}-#{key}").to_s).to eq("#{keycode}, #{vk1} | #{vk2}")
      end
    end

    it "converts key expression in case-insensitive manner" do
      EXPECTED_RESULTS.each do |expression, result|
        expect(described_class.new(expression.swapcase).to_s).to eq(result)
      end
    end
  end
end
