require "dotremap/dsl"
require "dotremap/item"

module Dotremap::DSL::Root
  def item(name = nil, &block)
    item = Dotremap::Item.new(name)
    item.instance_exec(&block)
    childs << item
  end
end
