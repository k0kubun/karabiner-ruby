require "set"

module Karabiner::History
  def self.clear_histroy
    registered_applications.clear
    registered_scripts.clear
  end

  def self.register_application(application)
    registered_applications.add(application)
  end

  def self.register_script(script)
    registered_scripts.add(script)
  end

  def self.registered_applications
    @@registered_applications ||= Set.new
  end

  def self.registered_scripts
    @@registered_scripts ||= Set.new
  end
end
