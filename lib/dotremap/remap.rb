require "dotremap/key"
require "dotremap/property"

class Dotremap::Remap < Dotremap::Property
  def initialize(from, to)
    tos = [to].flatten

    super(
      "autogen",
      [
        "__KeyToKey__ #{Dotremap::Key.new(from)}",
        *tos.map { |to| Dotremap::Key.new(to) },
      ].join(", "),
    )
  end
end
