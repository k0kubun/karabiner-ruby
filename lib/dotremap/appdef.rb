require "dotremap/xml_tree"

class Dotremap::Appdef
  include Dotremap::XmlTree

  AVAILABLE_OPTIONS = %i(
    equal
    prefix
    suffix
  ).freeze

  def initialize(appname, options)
    @appname = appname

    options.each do |option, value|
      raise "Unavailable option: #{property}" unless AVAILABLE_OPTIONS.include?(option)

      property = Dotremap::Property.new(option, value)
      add_child(property)
    end
  end

  def to_xml
    [
      "<appdef>",
      [
        "<appname>#{@appname}</appname>",
        *childs.map(&:to_xml),
      ].join("\n").gsub(/^/, "  "),
      "</appdef>",
    ].join("\n")
  end
end
