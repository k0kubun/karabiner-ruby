require "dotremap/dsl"
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
    childs << remap
  end

  def show_message(message)
    property = Dotremap::Property.new("autogen", "__ShowStatusMessage__ #{message}")
    childs << property
  end

  def invoke(application)
    Dotremap::Openurl.register(application)
    "VK_OPEN_URL_APP_#{application.gsub(/ /, '_')}"
  end

  private

  def method_missing(property, value = '', options = {})
    if AVAILABLE_PROPERTIES.include?(property)
      property = Dotremap::Property.new(property, value, options)
      childs << property
    else
      super
    end
  end
end
