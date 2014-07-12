class Dotremap::Remap
  KEYCODE_MAP = {
    "Up"    => "CURSOR_UP",
    "Down"  => "CURSOR_DOWN",
    "Right" => "CURSOR_RIGHT",
    "Left"  => "CURSOR_LEFT",
    "]"   => "BRACKET_RIGHT",
    "["   => "BRACKET_LEFT",
  }.freeze
  KEY_EXPRESSION = "([A-Z]|#{KEYCODE_MAP.keys.map { |k| Regexp.escape(k) }.join('|')})"

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
    raw_key = raw_combination.match(/#{KEY_EXPRESSION}$/).to_s

    case raw_combination
    when /^Cmd-#{KEY_EXPRESSION}$/
      "#{key_expression(raw_key)}, VK_COMMAND"
    when /^Cmd-Opt-#{KEY_EXPRESSION}$/
      "#{key_expression(raw_key)}, VK_COMMAND | VK_OPTION"
    when /^Cmd-Shift-#{KEY_EXPRESSION}$/
      "#{key_expression(raw_key)}, VK_COMMAND | VK_SHIFT"
    when /^#{KEY_EXPRESSION}$/
      key_expression(raw_key)
    else
      raw_combination
    end
  end

  def key_expression(raw_key)
    case raw_key
    when /^[A-Z]$/
      "KeyCode::#{raw_key}"
    when /^(#{KEYCODE_MAP.keys.map { |k| Regexp.escape(k) }.join('|')})$/
      "KeyCode::#{KEYCODE_MAP[raw_key]}"
    else
      raw_key
    end
  end
end
