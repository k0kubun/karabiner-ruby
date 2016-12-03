class Karabiner::Key
  def self.normalize_input(raw_input)
    if raw_input.match(/^VK_/)
      raw_input
    else
      raw_input = raw_input.tr(' ', '_').tr('+', '-').upcase
    end
  end

  def self.normalize_and_freeze!(map)
    map.tap do |h|
      h.keys.each { |k| h[normalize_input(k)] = h.delete(k) }
    end
    map.freeze
  end

  # Karabiner full keycode reference:
  # https://pqrs.org/osx/karabiner/xml.html#keycode-list
  KEYCODE_MAP = normalize_and_freeze!({
    "nil"        => "VK_NONE",
    "none"       => "VK_NONE",
    "0"          => "KEY_0",
    "1"          => "KEY_1",
    "2"          => "KEY_2",
    "3"          => "KEY_3",
    "4"          => "KEY_4",
    "5"          => "KEY_5",
    "6"          => "KEY_6",
    "7"          => "KEY_7",
    "8"          => "KEY_8",
    "9"          => "KEY_9",
    "Up"         => "CURSOR_UP",
    "Down"       => "CURSOR_DOWN",
    "Right"      => "CURSOR_RIGHT",
    "Left"       => "CURSOR_LEFT",
    "]"          => "BRACKET_RIGHT",
    "["          => "BRACKET_LEFT",
    ";"          => "SEMICOLON",
    "-"          => "MINUS",
    ","          => "COMMA",
    "."          => "DOT",
    "\\"         => "BACKSLASH",
    "/"          => "SLASH",
    "            =  "                => "EQUAL",
    "'"          => "QUOTE",
    "`"          => "BACKQUOTE",
    "Ctrl_R"     => "CONTROL_R",
    "Ctrl_L"     => "CONTROL_L",
    "Alt_R"      => "OPTION_R",
    "Alt_L"      => "OPTION_L",
    "Opt_R"      => "OPTION_R",
    "Opt_L"      => "OPTION_L",
    "Cmd_R"      => "COMMAND_R",
    "Cmd_L"      => "COMMAND_L",
    "Esc"        => "ESCAPE",
    "Jis_Atmark" => "JIS_ATMARK",
    "Jis_Colon"  => "JIS_COLON",
    "Jis_Eisuu"  => "JIS_EISUU",
    "Jis_Kana"   => "JIS_KANA",
    "Jis_Yen"    => "JIS_YEN",
  })
  CONSUMER_MAP = normalize_and_freeze!({
    "Brightness Down"     => "BRIGHTNESS_DOWN",
    "Brightness Up"       => "BRIGHTNESS_UP",
    "Keyboardlight Off"   => "KEYBOARDLIGHT_OFF",
    "Keyboardlight Low"   => "KEYBOARDLIGHT_LOW",
    "Keyboardlight High"  => "KEYBOARDLIGHT_HIGH",
    "Keyboard Light Off"  => "KEYBOARDLIGHT_OFF",
    "Keyboard Light Low"  => "KEYBOARDLIGHT_LOW",
    "Keyboard Light High" => "KEYBOARDLIGHT_HIGH",
    "Music Prev"          => "MUSIC_PREV",
    "Music Play"          => "MUSIC_PLAY",
    "Music Next"          => "MUSIC_NEXT",
    "Prev"                => "MUSIC_PREV",
    "Play"                => "MUSIC_PLAY",
    "Next"                => "MUSIC_NEXT",
    "Volume Mute"         => "VOLUME_MUTE",
    "Volume Down"         => "VOLUME_DOWN",
    "Volume Up"           => "VOLUME_UP",
    "Mute"                => "VOLUME_MUTE",
    "Eject"               => "EJECT",
    "Power"               => "POWER",
    "Numlock"             => "NUMLOCK",
    "Num Lock"            => "NUMLOCK",
    "Video Mirror"        => "VIDEO_MIRROR",
  })
  PREFIX_MAP = normalize_and_freeze!({
    "C"        => "VK_CONTROL",
    "Ctrl"     => "VK_CONTROL",
    "Cmd"      => "VK_COMMAND",
    "Shift"    => "VK_SHIFT",
    "M"        => "VK_OPTION",
    "Opt"      => "VK_OPTION",
    "Alt"      => "VK_OPTION",
  })
  PREFIX_EXPRESSION = "(#{PREFIX_MAP.keys.map { |k| k + '-' }.join('|')})"

  def initialize(expression)
    @expression = expression
  end

  def to_s
    key_combination(@expression)
  end

  private

  def key_combination(raw_combination)
    return "KeyCode::VK_NONE" if raw_combination.nil?
    raw_combination = normalize_key_combination(raw_combination)
    raw_prefixes, raw_key = split_key_combination(raw_combination)
    return key_expression(raw_key) if raw_prefixes.empty?

    prefixes = raw_prefixes.map { |raw_prefix| PREFIX_MAP[raw_prefix] }
    "#{key_expression(raw_key)}, #{prefixes.join(' | ')}"
  end

  def key_expression(raw_key)
    case raw_key
    when /^#{Regexp.union(KEYCODE_MAP.keys)}$/
      "KeyCode::#{KEYCODE_MAP[raw_key]}"
    when /^#{Regexp.union(CONSUMER_MAP.keys)}$/
      "ConsumerKeyCode::#{CONSUMER_MAP[raw_key]}"
    else
      "KeyCode::#{raw_key}"
    end
  end

  def normalize_key_combination(raw_combination)
    self.class.normalize_input(raw_combination)
  end

  def split_key_combination(raw_combination)
    prefixes = []
    key = raw_combination.dup

    while key.match(/^#{PREFIX_EXPRESSION}/)
      key.gsub!(/^#{PREFIX_EXPRESSION}/) do
        prefixes << $1.gsub(/-$/, "")
        ""
      end
    end

    [prefixes, key]
  end
end
