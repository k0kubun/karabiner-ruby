class Dotremap::Property
  def initialize(attr, value)
    @attr = attr.to_s
    @value = value
  end
  attr_accessor :attr, :value

  def to_xml
    "<#{attr}>#{value}</#{attr}>"
  end
end
