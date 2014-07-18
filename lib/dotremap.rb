require "dotremap/version"
require "dotremap/root"
require "unindent"
require "fileutils"

class Dotremap
  XML_FILE_NAME = "private.xml"
  OLD_XML_DIR = File.expand_path("~/Library/Application Support/KeyRemap4MacBook")
  NEW_XML_DIR = File.expand_path("~/Library/Application Support/Karabiner")
  OLD_APP_PATH = "/Applications/KeyRemap4MacBook.app"
  NEW_APP_PATH = "/Applications/Karabiner.app"
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
    ensure_xml_dir_existence
    remove_current_xml
    write_new_xml
  end

  def reload_xml
    app_path = File.exists?(OLD_APP_PATH) ? OLD_APP_PATH : NEW_APP_PATH
    reload_xml_path = File.join(app_path, RELOAD_XML_PATH)

    system("open #{reload_xml_path}")
  end

  def ensure_xml_dir_existence
    FileUtils.mkdir_p(OLD_XML_DIR)
    FileUtils.mkdir_p(NEW_XML_DIR)
  end

  def remove_current_xml
    FileUtils.rm_f(File.join(OLD_XML_DIR, XML_FILE_NAME))
    FileUtils.rm_f(File.join(NEW_XML_DIR, XML_FILE_NAME))
  end

  def write_new_xml
    File.write(File.join(OLD_XML_DIR, XML_FILE_NAME), new_xml)
    File.write(File.join(NEW_XML_DIR, XML_FILE_NAME), new_xml)
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
