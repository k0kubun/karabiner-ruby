require "dotremap/namespace"
require "dotremap/appdef"
require "dotremap/config"
require "dotremap/item"
require "dotremap/group"
require "dotremap/dsl/group"

module Karabiner::DSL::Root
  include Karabiner::DSL::Group

  def group(name, &block)
    group = Karabiner::Group.new(name)
    group.instance_exec(&block)
    add_child(group)
  end

  def config(name, &block)
    config = Karabiner::Config.new(name)
    config.parent = self
    config.instance_exec(&block)
    add_config(config)
  end

  def appdef(appname = '', options = {})
    appdef = Karabiner::Appdef.new(appname, options)
    add_child(appdef)
  end
end
