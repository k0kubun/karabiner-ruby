class Dotremap::Remap
  KEYCODE_MAP = {
    "Ctrl_R" => "CONTROL_R",
    "Ctrl_L" => "CONTROL_L",
    "Opt_R"  => "OPTION_R",
    "Opt_L"  => "OPTION_L",
    "Cmd_R"  => "COMMAND_R",
    "Cmd_L"  => "COMMAND_L",
    "Up"     => "CURSOR_UP",
    "Down"   => "CURSOR_DOWN",
    "Right"  => "CURSOR_RIGHT",
    "Left"   => "CURSOR_LEFT",
    "]"      => "BRACKET_RIGHT",
    "["      => "BRACKET_LEFT",
  }.freeze
  PREFIX_MAP = {
    "C"     => "VK_CONTROL",
    "Ctrl"  => "VK_CONTROL",
    "Cmd"   => "VK_COMMAND",
    "Shift" => "VK_SHIFT",
    "M"     => "VK_OPTION",
    "Opt"   => "VK_OPTION",
  }.freeze
  PREFIX_EXPRESSION = "(#{PREFIX_MAP.keys.map { |k| k + '-' }.join('|')})"

  def initialize(from, to)
    @from = from
    @to = to
  end

  def to_xml
    "<autogen>__KeyToKey__ #{from}, #{to}</autogen>"
  end

  private

  def from
    key_combination(@from)
  end

  def to
    key_combination(@to)
  end

  def key_combination(raw_combination)
    raw_prefixes, raw_key = split_key_combination(raw_combination)
    return key_expression(raw_key) if raw_prefixes.empty?

    prefixes = raw_prefixes.map { |raw_prefix| PREFIX_MAP[raw_prefix] }
    "#{key_expression(raw_key)}, #{prefixes.join(' | ')}"
  end

  def key_expression(raw_key)
    case raw_key
    when /^(#{KEYCODE_MAP.keys.map { |k| Regexp.escape(k) }.join('|')})$/
      "KeyCode::#{KEYCODE_MAP[raw_key]}"
    else
      "KeyCode::#{raw_key.upcase}"
    end
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
