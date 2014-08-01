require "dotremap/namespace"
require "dotremap/appdef"
require "dotremap/item"
require "dotremap/group"
require "dotremap/dsl/group"

module Dotremap::DSL::Root
  include Dotremap::DSL::Group

  def group(name, &block)
    group = Dotremap::Group.new(name)
    group.instance_exec(&block)
    add_child(group)
  end

  def appdef(appname = '', options = {})
    appdef = Dotremap::Appdef.new(appname, options)
    add_child(appdef)
  end
end
