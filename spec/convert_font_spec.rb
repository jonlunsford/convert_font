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
  let(:converter) {converter = ConvertFont::Converter.new config["api_key"], config["api_url"]}

  it "should accept an api key" do
    converter.api_key.should eq config["api_key"]
  end

  it "should accept an api url" do
    converter.api_url.should eq config["api_url"]
  end

  it "should set an api key as a default header" do
    converter.set_default_request_headers.should_not be_nil
  end

  it "should make a successful post to an api" do
    converter.convert(File.dirname(__FILE__) + "/convert_font/SourceSansPro-Regular.otf", [:ttf, :woff, :eot]) 
  end
end