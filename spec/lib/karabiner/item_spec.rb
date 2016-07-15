require "spec_helper"

describe Karabiner::Item do
  describe "#to_xml" do
    it "generates valid identifier from name" do
      item = described_class.new("Change MUSIC_PLAY to 9")
      expect(item.to_xml).to eq(<<-EOS.unindent.strip)
        <item>
          <name>Change MUSIC_PLAY to 9</name>
          <identifier>remap.change_music_play_to_9</identifier>
        </item>
      EOS
    end
  end
end
