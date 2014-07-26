require "spec_helper"

describe Dotremap::Karabiner do
  describe ".current_config" do
    subject { described_class.current_config }

    let(:cli_path) { Dotremap::Karabiner::CLI_PATH }

    before do
      allow_any_instance_of(Kernel).to receive(:'`').with("#{cli_path} export").and_return(<<-EOS.unindent)
        #!/bin/sh

        cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

        $cli set remap.command_k_to_command_l 1
        /bin/echo -n .
        $cli set repeat.initial_wait 100
        /bin/echo -n .
        $cli set repeat.wait 20
        /bin/echo -n .
        $cli set option.terminal_command_option 1
        /bin/echo -n .
        /bin/echo
      EOS
    end

    it "returns config hash" do
      expect(subject).to eq({
        "option.terminal_command_option" => "1",
        "remap.command_k_to_command_l"   => "1",
        "repeat.initial_wait"            => "100",
        "repeat.wait"                    => "20",
      })
    end
  end
end
