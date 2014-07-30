require "dotremap/openurl"
require "dotremap/dsl/root"

class Dotremap::Root
  include Dotremap::XmlTree
  include Dotremap::DSL::Root

  def to_xml
    [
      "<?xml version=\"1.0\"?>",
      "<root>",
      [
        childs.map(&:to_xml).join("\n\n"),
        Dotremap::Openurl.registered_xml,
      ].compact.join("\n").gsub(/^/, "  "),
      "</root>",
    ].join("\n")
  end
end
