require "spec_helper"

describe Dotremap::Karabiner do
  describe ".current_config" do
    subject { described_class.current_config }

    let(:cli_path) { Dotremap::Karabiner::CLI_PATH }

    before do
      allow_any_instance_of(Kernel).to receive(:'`').with("#{cli_path} changed").and_return(<<-EOS.unindent)
        remap.command_k_to_command_l=1
        repeat.initial_wait=100
        repeat.wait=20
        option.terminal_command_option=1
        notsave.automatically_enable_keyboard_device=1
      EOS
    end

    it "returns config hash" do
      expect(subject).to eq({
        "option.terminal_command_option"               => "1",
        "remap.command_k_to_command_l"                 => "1",
        "repeat.initial_wait"                          => "100",
        "repeat.wait"                                  => "20",
        "notsave.automatically_enable_keyboard_device" => "1",
      })
    end
  end
end
