require "dotremap/namespace"
require "dotremap/appdef"
require "dotremap/item"

module Dotremap::DSL::Root
  def item(name = nil, options = {}, &block)
    item = Dotremap::Item.new(name, options)
    item.instance_exec(&block)
    childs << item
  end

  def appdef(appname = '', options = {})
    appdef = Dotremap::Appdef.new(appname, options)
    childs << appdef
  end
end
