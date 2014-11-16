require "dotremap/invoke_history"
require "dotremap/vkopenurldef"
require "dotremap/dsl/root"

class Karabiner::Root
  include Karabiner::XmlTree
  include Karabiner::DSL::Root

  def initialize
    @configs = []
  end

  def to_xml
    Karabiner::InvokeHistory.registered_applications.each do |application|
      vkopenurldef = Karabiner::Vkopenurldef.new(application)
      add_child(vkopenurldef)
    end

    [
      "<?xml version=\"1.0\"?>",
      super(1),
    ].join("\n")
  end

  private

  def add_config(config)
    @configs << config
  end
end
