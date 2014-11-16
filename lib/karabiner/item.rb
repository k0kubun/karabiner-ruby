require "karabiner/dsl/item"
require "karabiner/xml_tree"

class Karabiner::Item
  include Karabiner::XmlTree
  include Karabiner::DSL::Item

  AVAILABLE_OPTIONS = %i(
    not
    only
    config_not
    config_only
  ).freeze

  def initialize(name, options = {})
    @skip_identifier = options.delete(:skip_identifier)

    if name
      property = Karabiner::Property.new("name", name)
      add_child(property)
    end

    options.each do |option, value|
      raise "Unavailable option: #{option}" unless AVAILABLE_OPTIONS.include?(option)

      property = Karabiner::Property.new(option, value)
      add_child(property)
    end
  end

  def to_xml
    validate_name_existence
    generate_identifier unless @skip_identifier

    super
  end

  private

  def validate_name_existence
    properties = search_childs(Karabiner::Property)
    raise "Name property does not exist" unless properties.map(&:attr).include?("name")
  end

  def generate_identifier
    properties = search_childs(Karabiner::Property)
    return if properties.map(&:attr).include?("identifier")

    name = properties.find { |p| p.attr == "name" }
    generated_identifier = name.value.gsub(/[^a-zA-Z]/, "_").downcase
    identifier = Karabiner::Property.new("identifier", "remap.#{generated_identifier}")
    childs[1, 0] = identifier
  end
end
