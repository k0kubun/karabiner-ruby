require "karabiner/history"
require "karabiner/namespace"
require "karabiner/property"
require "karabiner/remap"
require "karabiner/vkopenurldef"

module Karabiner::DSL::Item
  AVAILABLE_PROPERTIES = %i[
    name
    identifier
    autogen
  ].freeze

  def remap(target, options = {})
    remap = Karabiner::Remap.new(target, options[:to])
    add_child(remap)
  end

  def show_message(message)
    property = Karabiner::Property.new("autogen", "__ShowStatusMessage__ #{message}")
    add_child(property)
  end

  def invoke(application)
    Karabiner::History.register_application(application)
    Karabiner::Vkopenurldef.application_keycode(application)
  end

  def execute(script)
    Karabiner::History.register_script(script)
    Karabiner::Vkopenurldef.script_keycode(script)
  end

  private

  def method_missing(property, value = '', options = {})
    if AVAILABLE_PROPERTIES.include?(property)
      property = Karabiner::Property.new(property, value, options)
      add_child(property)
    else
      super
    end
  end
end
