require "dotremap/xml_tree"

class Dotremap::Vkopenurldef
  include Dotremap::XmlTree

  def initialize(application)
    name = Dotremap::Property.new("name", "KeyCode::VK_OPEN_URL_APP_#{application.gsub(/ /, "_")}")
    url  = Dotremap::Property.new("url", "/Applications/#{application}.app", type: "file")
    add_child(name, url)
  end
end
