require "spec_helper"
require "tempfile"

describe Dotremap do
  let!(:config) { Tempfile.new(".remap") }
  let(:xml_dir) { "/tmp" }
  let(:xml_path) { File.join(xml_dir, Dotremap::XML_FILE_NAME) }
  let(:result) { File.read(xml_path) }

  before do
    stub_const("Dotremap::XML_DIR", xml_dir)
    allow_any_instance_of(Dotremap).to receive(:reload_xml)
  end

  after do
    config.close!
  end

  def expect_result(expected_result)
    dotremap = Dotremap.new(config.path)
    dotremap.apply_configuration
    expect(result).to eq(expected_result)
  end

  it "succeeds to run spec" do
    config.write("")
    expect_result(<<-EOS.unindent)
      <?xml version="1.0"?>
      <root>

      </root>
    EOS
  end
end
