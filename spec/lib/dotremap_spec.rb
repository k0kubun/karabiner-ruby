require "spec_helper"
require "tempfile"

describe Karabiner do
  let!(:config) { Tempfile.new(".karabiner") }
  let(:xml_dir) { "/tmp" }
  let(:xml_path) { File.join(xml_dir, Karabiner::XML_FILE_NAME) }
  let(:result) { File.read(xml_path) }

  before do
    stub_const("Karabiner::XML_DIR", xml_dir)
    allow(Karabiner::CLI).to receive(:reload_xml)

    # Silence stdout
    allow_any_instance_of(Kernel).to receive(:puts)
  end

  after do
    config.close!
  end

  def prepare_karabiner(karabiner)
    config.write(karabiner)
    config.rewind
  end

  def expect_result(expected_result)
    karabiner = Karabiner.new(config.path)
    karabiner.apply_configuration
    expect(result).to eq(expected_result)
  end

  it "accepts blank config" do
    prepare_karabiner("")

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>

      </root>
    EOS
  end

  it "accepts cmd combination" do
    prepare_karabiner(<<-EOS)
      item "Command+A to Command+B" do
        remap "Cmd-A", to: "Cmd-B"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>Command+A to Command+B</name>
          <identifier>remap.command_a_to_command_b</identifier>
          <autogen>__KeyToKey__ KeyCode::A, VK_COMMAND, KeyCode::B, VK_COMMAND</autogen>
        </item>
      </root>
    EOS
  end

  it "accepts multiple remaps" do
    prepare_karabiner(<<-EOS)
      item "multiple remaps" do
        remap "Cmd-A", to: "Cmd-B"
        remap "Shift-A", to: "Shift-B"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>multiple remaps</name>
          <identifier>remap.multiple_remaps</identifier>
          <autogen>__KeyToKey__ KeyCode::A, VK_COMMAND, KeyCode::B, VK_COMMAND</autogen>
          <autogen>__KeyToKey__ KeyCode::A, VK_SHIFT, KeyCode::B, VK_SHIFT</autogen>
        </item>
      </root>
    EOS
  end

  it "accepts multiple items" do
    prepare_karabiner(<<-EOS)
      item "first item" do
        remap "Cmd-C-A", to: "Cmd-M-B"
      end

      item "second item" do
        remap "Shift-Opt-A", to: "Shift-Cmd-B"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>first item</name>
          <identifier>remap.first_item</identifier>
          <autogen>__KeyToKey__ KeyCode::A, VK_COMMAND | VK_CONTROL, KeyCode::B, VK_COMMAND | VK_OPTION</autogen>
        </item>

        <item>
          <name>second item</name>
          <identifier>remap.second_item</identifier>
          <autogen>__KeyToKey__ KeyCode::A, VK_SHIFT | VK_OPTION, KeyCode::B, VK_SHIFT | VK_COMMAND</autogen>
        </item>
      </root>
    EOS
  end

  it "accepts appdef and app option" do
    prepare_karabiner(<<-EOS)
      appdef "CHROME", equal: "com.google.Chrome"

      item "Command+K to Command+L", only: "CHROME" do
        remap "Cmd-K", to: "Cmd-L"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <appdef>
          <appname>CHROME</appname>
          <equal>com.google.Chrome</equal>
        </appdef>

        <item>
          <name>Command+K to Command+L</name>
          <identifier>remap.command_k_to_command_l</identifier>
          <only>CHROME</only>
          <autogen>__KeyToKey__ KeyCode::K, VK_COMMAND, KeyCode::L, VK_COMMAND</autogen>
        </item>
      </root>
    EOS
  end

  it "accepts config and show_message" do
    prepare_karabiner(<<-EOS)
      item "CapsLock ON", config_not: "notsave.private_capslock_on" do
        remap "Cmd-L", to: ["capslock", "VK_CONFIG_FORCE_ON_notsave_private_capslock_on"]
      end

      item "CapsLock OFF", config_only: "notsave.private_capslock_on" do
        remap "Cmd-L", to: ["capslock", "VK_CONFIG_FORCE_OFF_notsave_private_capslock_on"]
      end

      item "CapsLock Mode" do
        identifier "notsave.private_capslock_on", vk_config: "true"
        show_message "CapsLock"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>CapsLock ON</name>
          <identifier>remap.capslock_on</identifier>
          <config_not>notsave.private_capslock_on</config_not>
          <autogen>__KeyToKey__ KeyCode::L, VK_COMMAND, KeyCode::CAPSLOCK, KeyCode::VK_CONFIG_FORCE_ON_notsave_private_capslock_on</autogen>
        </item>

        <item>
          <name>CapsLock OFF</name>
          <identifier>remap.capslock_off</identifier>
          <config_only>notsave.private_capslock_on</config_only>
          <autogen>__KeyToKey__ KeyCode::L, VK_COMMAND, KeyCode::CAPSLOCK, KeyCode::VK_CONFIG_FORCE_OFF_notsave_private_capslock_on</autogen>
        </item>

        <item>
          <name>CapsLock Mode</name>
          <identifier vk_config="true">notsave.private_capslock_on</identifier>
          <autogen>__ShowStatusMessage__ CapsLock</autogen>
        </item>
      </root>
    EOS
  end

  it "accepts implicit autogen selection" do
    prepare_karabiner(<<-EOS)
      item "Control+LeftClick to Command+LeftClick" do
        autogen "__PointingButtonToPointingButton__ PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL, PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_COMMAND"
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>Control+LeftClick to Command+LeftClick</name>
          <identifier>remap.control_leftclick_to_command_leftclick</identifier>
          <autogen>__PointingButtonToPointingButton__ PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL, PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_COMMAND</autogen>
        </item>
      </root>
    EOS
  end

  it "application invoking" do
    prepare_karabiner(<<-EOS)
      item "Application shortcuts" do
        remap "C-o", to: invoke("YoruFukurou")
        remap "C-u", to: invoke("Google Chrome")
        remap "C-h", to: invoke("iTerm")
      end

      item "duplicate app" do
        remap "C-a", to: invoke("YoruFukurou")
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>Application shortcuts</name>
          <identifier>remap.application_shortcuts</identifier>
          <autogen>__KeyToKey__ KeyCode::O, VK_CONTROL, KeyCode::VK_OPEN_URL_APP_YoruFukurou</autogen>
          <autogen>__KeyToKey__ KeyCode::U, VK_CONTROL, KeyCode::VK_OPEN_URL_APP_Google_Chrome</autogen>
          <autogen>__KeyToKey__ KeyCode::H, VK_CONTROL, KeyCode::VK_OPEN_URL_APP_iTerm</autogen>
        </item>

        <item>
          <name>duplicate app</name>
          <identifier>remap.duplicate_app</identifier>
          <autogen>__KeyToKey__ KeyCode::A, VK_CONTROL, KeyCode::VK_OPEN_URL_APP_YoruFukurou</autogen>
        </item>

        <vkopenurldef>
          <name>KeyCode::VK_OPEN_URL_APP_YoruFukurou</name>
          <url type="file">/Applications/YoruFukurou.app</url>
        </vkopenurldef>

        <vkopenurldef>
          <name>KeyCode::VK_OPEN_URL_APP_Google_Chrome</name>
          <url type="file">/Applications/Google Chrome.app</url>
        </vkopenurldef>

        <vkopenurldef>
          <name>KeyCode::VK_OPEN_URL_APP_iTerm</name>
          <url type="file">/Applications/iTerm.app</url>
        </vkopenurldef>
      </root>
    EOS
  end

  it "accepts group items" do
    prepare_karabiner(<<-EOS)
      group "Option" do
        item "First" do
          identifier "option.option_first"
        end

        item "Second" do
          identifier "option.option_second"
        end
      end
    EOS

    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>
        <item>
          <name>Option</name>
          <item>
            <name>First</name>
            <identifier>option.option_first</identifier>
          </item>
          <item>
            <name>Second</name>
            <identifier>option.option_second</identifier>
          </item>
        </item>
      </root>
    EOS
  end

  context "when items are surrounded by config" do
    it "accepts cmd combination" do
      prepare_karabiner(<<-EOS)
        config "Default" do
          item "Command+A to Command+B" do
            remap "Cmd-A", to: "Cmd-B"
          end
        end
      EOS

      expect_result(<<-EOS.unindent)
        <?xml version="1.0"?>
        <root>
          <item>
            <name>Command+A to Command+B</name>
            <identifier>remap.command_a_to_command_b</identifier>
            <autogen>__KeyToKey__ KeyCode::A, VK_COMMAND, KeyCode::B, VK_COMMAND</autogen>
          </item>
        </root>
      EOS
    end

    it "accepts group items" do
      prepare_karabiner(<<-EOS)
        config "Original" do
          group "Option" do
            item "First" do
              identifier "option.option_first"
            end

            item "Second" do
              identifier "option.option_second"
            end
          end
        end
      EOS

      expect_result(<<-EOS.unindent)
        <?xml version="1.0"?>
        <root>
          <item>
            <name>Option</name>
            <item>
              <name>First</name>
              <identifier>option.option_first</identifier>
            </item>
            <item>
              <name>Second</name>
              <identifier>option.option_second</identifier>
            </item>
          </item>
        </root>
      EOS
    end
  end
end
