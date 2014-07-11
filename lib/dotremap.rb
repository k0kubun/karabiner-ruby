require "dotremap/version"
require "unindent"

class Dotremap
  def initialize(config_path)
    @config_path = config_path
  end
  attr_reader :config_path

  def compile
    validate_config_existence
  end

  def replace_private_xml
  end

  private

  def validate_config_existence
    return if File.exists?(config_path)

    File.write(config_path, <<-EOS.unindent)
      #!/usr/bin/env ruby

      # # Example
      # item do
      #   name 'Command+K to Command+L'
      #   identifier 'remap.command_k_to_command_l'
      #   autogen '__KeyToKey__ KeyCode::K, VK_COMMAND, KeyCode::L, VK_COMMAND'
      # end
    EOS
  end
end
