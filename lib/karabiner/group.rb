require "forwardable"
require "karabiner/namespace"
require "karabiner/dsl/group"

class Karabiner::Group
  extend Forwardable
  include Karabiner::XmlTree
  include Karabiner::DSL::Group

  def_delegator :@item, :to_xml
  def_delegator :@item, :add_child

  def initialize(name)
    @item = Karabiner::Item.new(name, skip_identifier: true)
  end
end
