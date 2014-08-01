require "dotremap/namespace"
require "dotremap/appdef"
require "dotremap/config"
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

  def config(name, &block)
    config = Dotremap::Config.new(name)
    config.parent = self
    config.instance_exec(&block)
    add_config(config)
  end

  def appdef(appname = '', options = {})
    appdef = Dotremap::Appdef.new(appname, options)
    add_child(appdef)
  end
end
