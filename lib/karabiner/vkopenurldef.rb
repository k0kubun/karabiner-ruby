require "karabiner/xml_tree"

class Karabiner::Vkopenurldef
  include Karabiner::XmlTree

  def self.application_keycode(application)
    "VK_OPEN_URL_APP_#{application.gsub(/ /, "_")}"
  end

  def self.for_application(application)
    self.new.tap do |definition|
      name = Karabiner::Property.new("name", "KeyCode::#{application_keycode(application)}")
      url  = Karabiner::Property.new("url", "/Applications/#{application}.app", type: "file")
      definition.add_child(name, url)
    end
  end
end
