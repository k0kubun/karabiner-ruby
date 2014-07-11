require "dotremap/dsl/root"

class Dotremap::Root
  include Dotremap::DSL::Root

  def initialize
    @childs = []
  end
  attr_reader :childs

  def to_xml
    <<-XML.unindent
      <?xml version="1.0"?>
      <root>
#{@childs.map { |c| c.to_xml.gsub(/^/, "        ") }.join("\n").gsub(/\n\Z/, '')}
      </root>
    XML
  end
end
