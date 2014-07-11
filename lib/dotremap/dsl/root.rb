require "dotremap/dsl"
require "dotremap/item"

module Dotremap::DSL::Root
  def item
    childs << Dotremap::Item.new
  end
end
