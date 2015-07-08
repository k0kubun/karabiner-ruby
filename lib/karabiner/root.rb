require "karabiner/dsl/root"
require "karabiner/history"
require "karabiner/vkopenurldef"

class Karabiner::Root
  include Karabiner::XmlTree
  include Karabiner::DSL::Root

  def initialize
    @configs = []
  end

  def to_xml
    Karabiner::History.registered_applications.each do |application|
      vkopenurldef = Karabiner::Vkopenurldef.for_application(application)
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
