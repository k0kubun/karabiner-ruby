require "dotremap/dsl/item"

class Dotremap::Item
  include Dotremap::DSL::Item

  AVAILABLE_OPTIONS = %i(
    not
    only
  ).freeze

  def initialize(name, options)
    @childs = []

    if name
      @childs << Dotremap::Property.new("name", name)
    end

    options.each do |option, value|
      raise "Unavailable option: #{option}" unless AVAILABLE_OPTIONS.include?(option)
      @childs << Dotremap::Property.new(option.to_s, value)
    end
  end
  attr_accessor :childs

  def to_xml
    [
      "<item>",
      childs.map(&:to_xml).join("\n").gsub(/^/, "  "),
      "</item>",
    ].join("\n")
  end
end
