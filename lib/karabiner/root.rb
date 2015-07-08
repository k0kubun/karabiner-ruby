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
    add_registered_applications
    add_registered_scripts

    [
      "<?xml version=\"1.0\"?>",
      super(1),
    ].join("\n")
  end

  private

  def add_registered_applications
    Karabiner::History.registered_applications.each do |application|
      vkopenurldef = Karabiner::Vkopenurldef.for_application(application)
      add_child(vkopenurldef)
    end
  end

  def add_registered_scripts
    Karabiner::History.registered_scripts.each do |script|
      vkopenurldef = Karabiner::Vkopenurldef.for_script(script)
      add_child(vkopenurldef)
    end
  end

  def add_config(config)
    @configs << config
  end
end
