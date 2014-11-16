class Karabiner::Property
  include Karabiner::XmlTree

  def initialize(attr, value, options = {})
    @attr = attr.to_s
    @value = value
    @options = options
  end
  attr_accessor :attr, :value

  def to_xml
    open_tag = @options.map { |a, v| "#{a}=\"#{v}\"" }.unshift(attr).join(" ")
    "<#{open_tag}>#{value}</#{attr}>"
  end
end
