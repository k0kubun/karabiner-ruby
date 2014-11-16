require "karabiner/namespace"
require "karabiner/item"

module Karabiner::DSL::Group
  def item(name = nil, options = {}, &block)
    item = Karabiner::Item.new(name, options)
    item.instance_exec(&block)
    add_child(item)
  end
end
