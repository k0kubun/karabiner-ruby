require "dotremap/dsl"
require "dotremap/property"
require "dotremap/remap"

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

  private

  def method_missing(property, value = '')
    if AVAILABLE_PROPERTIES.include?(property)
      property = Dotremap::Property.new(property, value)
      childs << property
    else
      super
    end
  end
end
