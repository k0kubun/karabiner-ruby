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

    it "generates unique identifiers for items with the same name" do
      root = described_class.new("Root", skip_identifier: true)
      3.times { root.add_child(described_class.new("The same name")) }
      expect(root.to_xml).to eq(<<-EOS.unindent.strip)
        <item>
          <name>Root</name>
          <item>
            <name>The same name</name>
            <identifier>remap.the_same_name</identifier>
          </item>
          <item>
            <name>The same name</name>
            <identifier>remap.the_same_name_2</identifier>
          </item>
          <item>
            <name>The same name</name>
            <identifier>remap.the_same_name_3</identifier>
          </item>
        </item>
      EOS
    end
  end
end
