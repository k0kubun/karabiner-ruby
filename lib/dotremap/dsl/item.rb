require "dotremap/dsl"
require "dotremap/property"

module Dotremap::DSL::Item
  AVAILABLE_PROPERTIES = %i(
    name
    identifier
    not
    only
    autogen
  ).freeze

  private

  def method_missing(property, value)
    if AVAILABLE_PROPERTIES.include?(property)
      property = Dotremap::Property.new(property, value)
      childs << property
    else
      super
    end
  end
end
