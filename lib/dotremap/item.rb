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
      @childs << Dotremap::Property.new(option, value)
    end
  end
  attr_accessor :childs

  def to_xml
    validate_name_existence
    generate_identifier

    [
      "<item>",
      childs.map(&:to_xml).join("\n").gsub(/^/, "  "),
      "</item>",
    ].join("\n")
  end

  private

  def validate_name_existence
    properties = childs.select { |c| c.is_a?(Dotremap::Property) }
    raise "Name property does not exist" unless properties.map(&:attr).include?("name")
  end

  def generate_identifier
    properties = childs.select { |c| c.is_a?(Dotremap::Property) }
    return if properties.map(&:attr).include?("identifier")

    name = properties.find { |p| p.attr == "name" }
    generated_identifier = name.value.gsub(/[^a-zA-Z]/, "_").downcase
    identifier = Dotremap::Property.new("identifier", "remap.#{generated_identifier}")
    childs[1, 0] = identifier
  end
end
