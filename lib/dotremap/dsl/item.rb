require "dotremap/namespace"
require "dotremap/property"
require "dotremap/remap"
require "dotremap/openurl"

module Dotremap::DSL::Item
  AVAILABLE_PROPERTIES = %i(
    name
    identifier
    autogen
  ).freeze

  def remap(target, options = {})
    remap = Dotremap::Remap.new(target, options[:to])
    add_child(remap)
  end

  def show_message(message)
    property = Dotremap::Property.new("autogen", "__ShowStatusMessage__ #{message}")
    add_child(property)
  end

  def invoke(application)
    Dotremap::Openurl.register(application)
    "VK_OPEN_URL_APP_#{application.gsub(/ /, '_')}"
  end

  private

  def method_missing(property, value = '', options = {})
    if AVAILABLE_PROPERTIES.include?(property)
      property = Dotremap::Property.new(property, value, options)
      add_child(property)
    else
      super
    end
  end
end
