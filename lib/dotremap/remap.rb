require "dotremap/key"

class Dotremap::Remap
  def initialize(from, to)
    @from = from
    @to = to
  end

  def to_xml
    "<autogen>__KeyToKey__ #{from}, #{to}</autogen>"
  end

  private

  def from
    Dotremap::Key.new(@from)
  end

  def to
    [@to].flatten.map { |to| Dotremap::Key.new(to) }.join(", ")
  end
end
