require "set"
require "dotremap/vkopenurldef"

module Karabiner::InvokeHistory
  def self.clear_histroy
    @@registered_applications = Set.new
  end

  def self.register(application)
    registered_applications.add(application)
  end

  def self.registered_applications
    @@registered_applications ||= Set.new
  end
end
