require "spec_helper"

describe Karabiner::Key do
  describe ".normalize_input" do
    it { expect(described_class.normalize_input('Cmd+Volume Up')).to eq('CMD-VOLUME_UP') }
  end

  describe "#to_s" do
    EXPECTED_RESULTS = {
      "nil"     => "KeyCode::VK_NONE",
      "none"    => "KeyCode::VK_NONE",
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
      "Shift_R" => "KeyCode::SHIFT_R",
      "Shift_L" => "KeyCode::SHIFT_L",
      "Esc"     => "KeyCode::ESCAPE",
      "Jis_Atmark" => "JIS_ATMARK",
      "Jis_Colon"  => "JIS_COLON",
      "Jis_Eisuu"  => "JIS_EISUU",
      "Jis_Kana"   => "JIS_KANA",
      "Jis_Yen"    => "JIS_YEN",

      "Brightness Down"     => "ConsumerKeyCode::BRIGHTNESS_DOWN",
      "Brightness Up"       => "ConsumerKeyCode::BRIGHTNESS_UP",
      "Keyboardlight Off"   => "ConsumerKeyCode::KEYBOARDLIGHT_OFF",
      "Keyboardlight Low"   => "ConsumerKeyCode::KEYBOARDLIGHT_LOW",
      "Keyboardlight High"  => "ConsumerKeyCode::KEYBOARDLIGHT_HIGH",
      "Keyboard Light Off"  => "ConsumerKeyCode::KEYBOARDLIGHT_OFF",
      "Keyboard Light Low"  => "ConsumerKeyCode::KEYBOARDLIGHT_LOW",
      "Keyboard Light High" => "ConsumerKeyCode::KEYBOARDLIGHT_HIGH",
      "Music Prev"          => "ConsumerKeyCode::MUSIC_PREV",
      "Music Play"          => "ConsumerKeyCode::MUSIC_PLAY",
      "Music Next"          => "ConsumerKeyCode::MUSIC_NEXT",
      "Prev"                => "ConsumerKeyCode::MUSIC_PREV",
      "Play"                => "ConsumerKeyCode::MUSIC_PLAY",
      "Next"                => "ConsumerKeyCode::MUSIC_NEXT",
      "Volume Mute"         => "ConsumerKeyCode::VOLUME_MUTE",
      "Volume Down"         => "ConsumerKeyCode::VOLUME_DOWN",
      "Volume Up"           => "ConsumerKeyCode::VOLUME_UP",
      "Mute"                => "ConsumerKeyCode::VOLUME_MUTE",
      "Eject"               => "ConsumerKeyCode::EJECT",
      "Power"               => "ConsumerKeyCode::POWER",
      "Numlock"             => "ConsumerKeyCode::NUMLOCK",
      "Num Lock"            => "ConsumerKeyCode::NUMLOCK",
      "Video Mirror"        => "ConsumerKeyCode::VIDEO_MIRROR",
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

    it "accepts nil class as key expression" do
      expect(described_class.new(nil).to_s).to eq("KeyCode::VK_NONE")
    end
  end
end
