require "dotremap/dsl/item"

class Dotremap::Item
  include Dotremap::DSL::Item

  def initialize(name)
    @childs = []

    if name
      @childs << Dotremap::Property.new("name", name)
    end
  end
  attr_reader :childs

  def to_xml
    [
      "<item>",
      childs.map(&:to_xml).join("\n").gsub(/^/, "  "),
      "</item>",
    ].join("\n")
  end
end
