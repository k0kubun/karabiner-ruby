require "dotremap/dsl/item"
require "dotremap/xml_tree"

class Dotremap::Item
  include Dotremap::XmlTree
  include Dotremap::DSL::Item

  AVAILABLE_OPTIONS = %i(
    not
    only
    config_not
    config_only
  ).freeze

  def initialize(name, options)
    if name
      property = Dotremap::Property.new("name", name)
      add_child(property)
    end

    options.each do |option, value|
      raise "Unavailable option: #{option}" unless AVAILABLE_OPTIONS.include?(option)

      property = Dotremap::Property.new(option, value)
      add_child(property)
    end
  end

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
    properties = search_childs(Dotremap::Property)
    raise "Name property does not exist" unless properties.map(&:attr).include?("name")
  end

  def generate_identifier
    properties = search_childs(Dotremap::Property)
    return if properties.map(&:attr).include?("identifier")

    name = properties.find { |p| p.attr == "name" }
    generated_identifier = name.value.gsub(/[^a-zA-Z]/, "_").downcase
    identifier = Dotremap::Property.new("identifier", "remap.#{generated_identifier}")
    childs[1, 0] = identifier
  end
end
