require "dotremap/version"
require "dotremap/root"
require "unindent"
require "fileutils"

class Dotremap
  XML_FILE_NAME = "private.xml"
  XML_DIR = File.expand_path("~/Library/Application Support/Karabiner")
  APP_PATH = "/Applications/Karabiner.app"
  RELOAD_XML_PATH = "Contents/Applications/Utilities/ReloadXML.app"

  def initialize(config_path)
    @config_path = config_path
  end
  attr_reader :config_path

  def apply_configuration
    replace_private_xml
    reload_xml
    puts "Successfully updated Karabiner configuration"
  end

  private

  def replace_private_xml
    FileUtils.mkdir_p(XML_DIR)

    xml_path = File.join(XML_DIR, XML_FILE_NAME)
    File.write(xml_path, new_xml)
  end

  def reload_xml
    reload_xml_path = File.join(APP_PATH, RELOAD_XML_PATH)
    system("open #{reload_xml_path}")
  end

  def new_xml
    return @new_xml if defined?(@new_xml)
    validate_config_existence

    root = Root.new
    config = File.read(config_path)
    root.instance_eval(config)
    @new_xml = root.to_xml.gsub(/ *$/, "")
  end

  def validate_config_existence
    return if File.exists?(config_path)

    File.write(config_path, <<-EOS.unindent)
      #!/usr/bin/env ruby

      # # Example
      # item "Command+E to Command+W", not: "TERMINAL" do
      #   identifier "option.not_terminal_opt_e"
      #   autogen "__KeyToKey__ KeyCode::E, VK_COMMAND, KeyCode::W, ModifierFlag::COMMAND_L"
      # end
    EOS
  end
end
