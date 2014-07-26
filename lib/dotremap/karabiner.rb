require "dotremap/version"

module Dotremap::Karabiner
  CLI_PATH = "/Applications/Karabiner.app/Contents/Library/bin/karabiner"

  def self.reload_xml
    system("#{CLI_PATH} reloadxml")
  end

  def self.current_config
    export = `#{CLI_PATH} export`
    config_by_export(export)
  end

  private

  def self.config_by_export(export)
    config = {}
    export.each_line do |line|
      if line =~ /^\$cli/
        property, value = line.strip.gsub(/\$cli set /, "").split(" ")
        config[property] = value
      end
    end
    config
  end
end
