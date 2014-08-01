require "forwardable"
require "dotremap/namespace"
require "dotremap/dsl/group"

class Dotremap::Group
  extend Forwardable
  include Dotremap::XmlTree
  include Dotremap::DSL::Group

  def_delegator :@item, :to_xml
  def_delegator :@item, :add_child

  def initialize(name)
    @item = Dotremap::Item.new(name, skip_identifier: true)
  end
end
