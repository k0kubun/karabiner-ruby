require "dotremap/version"
require "dotremap/root"
require "unindent"
require "fileutils"

class Dotremap
  OLD_XML_DIR = File.expand_path("~/Library/Application Support/KeyRemap4MacBook")
  NEW_XML_DIR = File.expand_path("~/Library/Application Support/Karabiner")
  XML_FILE_NAME = "private.xml"

  def initialize(config_path)
    @config_path = config_path
    @root = Root.new
  end
  attr_reader :config_path, :root

  def compile
    validate_config_existence

    config = File.read(config_path)
    root.instance_eval(config)
  end

  def replace_private_xml
    ensure_xml_dir_existence
    remove_current_xml
    write_new_xml
  end

  private

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

  def ensure_xml_dir_existence
    FileUtils.mkdir_p(OLD_XML_DIR)
    FileUtils.mkdir_p(NEW_XML_DIR)
  end

  def remove_current_xml
    FileUtils.rm_f(File.join(OLD_XML_DIR, XML_FILE_NAME))
    FileUtils.rm_f(File.join(NEW_XML_DIR, XML_FILE_NAME))
  end

  def write_new_xml
    File.write(File.join(OLD_XML_DIR, XML_FILE_NAME), root.to_xml)
    File.write(File.join(NEW_XML_DIR, XML_FILE_NAME), root.to_xml)
  end
end
