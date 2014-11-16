require "karabiner/key"
require "karabiner/property"

class Karabiner::Remap < Karabiner::Property
  def initialize(from, to)
    tos = [to].flatten

    super(
      "autogen",
      [
        "__KeyToKey__ #{Karabiner::Key.new(from)}",
        *tos.map { |to| Karabiner::Key.new(to) },
      ].join(", "),
    )
  end
end
