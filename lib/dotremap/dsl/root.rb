require "dotremap/dsl"
require "dotremap/item"

module Dotremap::DSL::Root
  def item(name = nil, options = {}, &block)
    item = Dotremap::Item.new(name, options)
    item.instance_exec(&block)
    childs << item
  end
end
