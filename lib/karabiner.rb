require "karabiner/cli"
require "karabiner/version"
require "karabiner/root"
require "unindent"
require "fileutils"

class Karabiner
  XML_FILE_NAME = "private.xml"
  XML_DIR = File.expand_path("~/Library/Application Support/Karabiner")

  def initialize(config_path)
    @config_path = config_path
    Karabiner::History.clear_histroy
  end
  attr_reader :config_path

  def apply_configuration
    replace_private_xml
    CLI.reload_xml

    puts "Successfully updated Karabiner configuration"
  end

  private

  def replace_private_xml
    FileUtils.mkdir_p(XML_DIR)

    xml_path = File.join(XML_DIR, XML_FILE_NAME)
    File.write(xml_path, new_xml)
  end

  def new_xml
    return @new_xml if defined?(@new_xml)
    validate_config_existence

    root = Root.new
    config = File.read(config_path)
    root.instance_eval(config)
    @new_xml = root.to_xml.gsub(/ *$/, "").concat("\n")
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
