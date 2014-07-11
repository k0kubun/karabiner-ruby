class Root
  def initialize
    @childs = []
  end

  def to_xml
    <<-XML.unindent
      <?xml version="1.0"?>
      <root>
      </root>
    XML
  end
end
