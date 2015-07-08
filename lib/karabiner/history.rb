require "set"
require "karabiner/vkopenurldef"

module Karabiner::History
  def self.clear_histroy
    @@registered_applications = Set.new
  end

  def self.register_application(application)
    registered_applications.add(application)
  end

  def self.registered_applications
    @@registered_applications ||= Set.new
  end
end
