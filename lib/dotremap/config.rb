require "forwardable"
require "dotremap/namespace"

class Karabiner::Config
  extend Forwardable

  def_delegator :@parent, :item
  def_delegator :@parent, :group

  def initialize(name)
    @name = name
  end

  attr_writer :parent
end
