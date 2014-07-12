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
    @from
  end

  def to
    @to
  end
end
