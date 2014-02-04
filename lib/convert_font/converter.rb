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

    def convert file, types
      response = Unirest.post @api_url, parameters: {"file" => File.new(file, "rb"), "format" => types[0]}

      open("temp_file.tar.gz", "w") do |temp_file|
        temp_file.write(response.body)
      end

      extract = Gem::Package::TarReader.new(Zlib::GzipReader.open("temp_file.tar.gz"))
      extract.rewind
      extract.each do |entry|
        if entry.file?
          names = entry.full_name.split("/")
          unless names.last.include? ".txt"
            open(names.last, "w") do |new_file|
              new_file.write(entry.read)
            end 
          end
        end
      end
      extract.close
    end

  end
end