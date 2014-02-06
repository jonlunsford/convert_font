require 'rubygems/package'
require 'zlib'
require 'unirest'

module ConvertFont
  class Converter

    attr_accessor :api_key, :api_url, :enable_cleanup

    def initialize api_key, api_url, enable_cleanup = true
      @api_key = api_key
      @api_url = api_url
      @enable_cleanup = enable_cleanup

      self.set_default_request_headers
    end
    
    def set_default_request_headers
      Unirest.default_header('X-Mashape-Authorization', @api_key)
    end

    def convert file, types, destination
      destination << "/" if destination[-1] != "/"
      types.to_enum.with_index(0).each do |type, i|
        puts "Now converting: #{type}"
        response = Unirest.post @api_url, parameters: {"file" => File.new(file, "rb"), "format" => type.to_s}
        open("#{destination}temp_font_#{type.to_s}.tar.gz", "w") do |temp_file|
          temp_file.write(response.body)
        end
        extract("#{destination}temp_font_#{type.to_s}.tar.gz", destination);
        puts "#{type} converted."
      end
    end

    def extract file, destination
      destination << "/" if destination[-1] != "/"
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
      FileUtils.rm_rf file if @enable_cleanup
    end

  end
end