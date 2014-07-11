require "dotremap/version"
require "dotremap/root"
require "unindent"

class Dotremap
  def initialize(config_path)
    @config_path = config_path
    @root = Root.new
  end
  attr_reader :config_path, :root

  def compile
    validate_config_existence

    config = File.read(config_path)
    root.instance_eval(config)

    # for debug
    puts root.to_xml
  end

  def replace_private_xml
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
end
