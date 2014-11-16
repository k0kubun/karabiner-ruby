require "karabiner/xml_tree"

class Karabiner::Appdef
  include Karabiner::XmlTree

  AVAILABLE_OPTIONS = %i(
    equal
    prefix
    suffix
  ).freeze

  def initialize(appname, options)
    property = Karabiner::Property.new("appname", appname)
    add_child(property)

    options.each do |option, value|
      raise "Unavailable option: #{property}" unless AVAILABLE_OPTIONS.include?(option)

      property = Karabiner::Property.new(option, value)
      add_child(property)
    end
  end
end
