require "dotremap/namespace"
require "dotremap/item"

module Dotremap::DSL::Group
  def item(name = nil, options = {}, &block)
    item = Dotremap::Item.new(name, options)
    item.instance_exec(&block)
    add_child(item)
  end
end
