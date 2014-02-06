require 'spec_helper'

describe ConvertFont do
  context "Dependencies" do
    it "depends on unirest" do
      Unirest.should_not be_nil
    end
  end
end

describe ConvertFont::Converter do
  # config_spec.yml is excluded from this repo, you must provide your own keys for deveopment purposes.
  let(:config) { YAML.load_file(File.dirname(__FILE__) + "/convert_font/config_spec.yml") }
  let(:converter) {converter = ConvertFont::Converter.new config["api_key"], config["api_url"], false}

  it "should accept an api key" do
    converter.api_key.should eq config["api_key"]
  end

  it "should accept an api url" do
    converter.api_url.should eq config["api_url"]
  end

  it "should set an api key as a default header" do
    converter.set_default_request_headers.should_not be_nil
  end

  it "should extract tar.qz files" do
    gzip = File.dirname(__FILE__) + "/convert_font/temp_font_ttf.tar.gz"
    font_file = File.dirname(__FILE__) + "/convert_font/SourceSansPro-Regular.ttf"
    FileUtils.rm_rf font_file if File.file?(font_file)
    converter.extract(gzip, File.dirname(__FILE__) + "/convert_font/")
    expect(File.file?(font_file)).to be true
  end

  it "should allow destination paths to NOT have a trailing slash" do
    gzip = File.dirname(__FILE__) + "/convert_font/temp_font_eot.tar.gz"
    font_file = File.dirname(__FILE__) + "/convert_font/SourceSansPro-Regular.eot"
    FileUtils.rm_rf font_file if File.file?(font_file)
    converter.extract(gzip, File.dirname(__FILE__) + "/convert_font")
    expect(File.file?(font_file)).to be true
  end
  
  it "should convert a font" do
    font_file = File.dirname(__FILE__) + "/convert_font/SourceSansPro-Regular.woff"
    FileUtils.rm_rf font_file if File.file?(font_file)
    converter.convert(File.dirname(__FILE__) + "/convert_font/SourceSansPro-Regular.otf", [:woff], File.dirname(__FILE__) + "/convert_font/")
    expect(File.file?(font_file)).to be true
  end
end