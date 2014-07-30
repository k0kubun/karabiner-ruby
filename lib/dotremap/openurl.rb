require "set"
require "dotremap/vkopenurldef"

module Dotremap::Openurl
  def self.register(application)
    registered_applications.add(application)
  end

  def self.registered_applications
    @@registered_applications ||= Set.new
  end
end
