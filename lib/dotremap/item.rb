class Dotremap::Item
  def initialize
    @childs = []
  end

  def to_xml
    <<-XML.unindent
      <item>
      </item>
    XML
  end
end
