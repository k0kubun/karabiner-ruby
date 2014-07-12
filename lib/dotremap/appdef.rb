class Dotremap::Appdef
  AVAILABLE_OPTIONS = %i(
    equal
    prefix
    suffix
  ).freeze

  def initialize(appname, options)
    @childs = []
    @appname = appname

    options.each do |option, value|
      raise "Unavailable option: #{property}" unless AVAILABLE_OPTIONS.include?(option)
      @childs << Dotremap::Property.new(option, value)
    end
  end

  def to_xml
    [
      "<appdef>",
      "  <appname>#{@appname}</appname>",
      @childs.map(&:to_xml).join("\n").gsub(/^/, "  "),
      "</appdef>",
    ].join("\n")
  end
end
