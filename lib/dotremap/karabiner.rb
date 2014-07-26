require "dotremap/version"

module Dotremap::Karabiner
  CLI_PATH = "/Applications/Karabiner.app/Contents/Library/bin/karabiner"

  def self.reload_xml
    system("#{CLI_PATH} reloadxml")
  end
end
