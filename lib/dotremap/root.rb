require "dotremap/openurl"
require "dotremap/dsl/root"

class Dotremap::Root
  include Dotremap::DSL::Root

  def initialize
    @childs = []
  end
  attr_accessor :childs

  def to_xml
    [
      "<?xml version=\"1.0\"?>",
      "<root>",
      childs.map(&:to_xml).join("\n\n").gsub(/^/, "  "),
      Dotremap::Openurl.registered_xml.gsub(/^/, "  "),
      "</root>",
    ].compact.join("\n")
  end
end
