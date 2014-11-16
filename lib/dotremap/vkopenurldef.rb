require "dotremap/xml_tree"

class Karabiner::Vkopenurldef
  include Karabiner::XmlTree

  def initialize(application)
    name = Karabiner::Property.new("name", "KeyCode::VK_OPEN_URL_APP_#{application.gsub(/ /, "_")}")
    url  = Karabiner::Property.new("url", "/Applications/#{application}.app", type: "file")
    add_child(name, url)
  end
end
