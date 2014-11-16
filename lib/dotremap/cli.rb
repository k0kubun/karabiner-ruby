require "dotremap/namespace"

module Karabiner::CLI
  CLI_PATH = "/Applications/Karabiner.app/Contents/Library/bin/karabiner"

  def self.reload_xml
    system("#{CLI_PATH} reloadxml")
  end

  def self.current_config
    changed = `#{CLI_PATH} changed`
    config_by_changed(changed)
  end

  private

  def self.config_by_changed(changed)
    config = {}
    changed.each_line do |line|
      property, value = line.strip.split("=")
      config[property] = value
    end
    config
  end
end
