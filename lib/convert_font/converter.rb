require 'rubygems/package'
require 'zlib'
require 'unirest'

module ConvertFont
  class Converter

    attr_accessor :api_key, :api_url

    def initialize api_key, api_url
      @api_key = api_key
      @api_url = api_url

      self.set_default_request_headers
    end
    
    def set_default_request_headers
      Unirest.default_header('X-Mashape-Authorization', @api_key)
    end

    def convert file, types, destination
      response = Unirest.post @api_url, parameters: {"file" => File.new(file, "rb"), "format" => types[0]}

      open("temp_font.tar.gz", "w") do |temp_file|
        temp_file.write(response.body)
      end

      extract("temp_font.tar.gz", destination);
    end

    def extract file, destination
      tar = Gem::Package::TarReader.new(Zlib::GzipReader.open(file))
      tar.rewind
      tar.each do |entry|
        if entry.file?
          names = entry.full_name.split("/")
          unless names.last.include? ".txt"
            open(destination + names.last, "wb") do |new_file|
              new_file.write(entry.read)
            end 
          end
        end
      end
      tar.close
      FileUtils.rm_rf 
    end

  end
end