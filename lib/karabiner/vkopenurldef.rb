require "karabiner/xml_tree"

class Karabiner::Vkopenurldef
  include Karabiner::XmlTree

  def self.application_keycode(application)
    "VK_OPEN_URL_APP_#{File.basename(application, '.app').gsub(/ /, "_")}"
  end

  def self.script_keycode(script)
    "VK_OPEN_URL_SHELL_#{script.gsub(/[^a-zA-Z]/, "_")}"
  end

  def self.for_application(application)
    self.new.tap do |definition|

      if application =~ %r|\A/.+app\z|
        app_url = application
      else
        app_url = "/Applications/#{application}.app"
      end

      name = Karabiner::Property.new("name", "KeyCode::#{application_keycode(application)}")
      url  = Karabiner::Property.new("url", app_url, type: "file")
      definition.add_child(name, url)
    end
  end

  def self.for_script(script)
    self.new.tap do |definition|
      name = Karabiner::Property.new("name", "KeyCode::#{script_keycode(script)}")
      url  = Karabiner::Property.new("url", "<![CDATA[ #{script} ]]>", type: "shell")
      definition.add_child(name, url)
    end
  end
end
