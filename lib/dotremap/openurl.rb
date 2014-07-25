require "set"

module Dotremap::Openurl
  def self.register(application)
    @@registered_applications ||= Set.new
    @@registered_applications.add(application)
  end

  def self.registered_xml
    return nil unless defined?(@@registered_applications)

    @@registered_applications.map { |a| vkopenurl(a) }.join("\n\n").prepend("\n")
  end

  def self.vkopenurl(application)
    <<-EOS.unindent.gsub(/\n\Z/, "")
      <vkopenurldef>
        <name>KeyCode::VK_OPEN_URL_APP_#{application.gsub(/ /, "_")}</name>
        <url type="file">/Applications/#{application}.app</url>
      </vkopenurldef>
    EOS
  end
end
