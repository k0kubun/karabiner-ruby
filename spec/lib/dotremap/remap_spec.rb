require "spec_helper"

describe Dotremap::Remap do
  describe "#to_xml" do
    it "converts key remap to autogen tag" do
      expect(Dotremap::Remap.new("Cmd-Shift-]", "Opt-Ctrl-Up").to_xml).
        to eq("<autogen>__KeyToKey__ KeyCode::BRACKET_RIGHT, VK_COMMAND | VK_SHIFT, KeyCode::CURSOR_UP, VK_OPTION | VK_CONTROL</autogen>")
    end
  end
end
