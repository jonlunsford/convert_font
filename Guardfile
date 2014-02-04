# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^convert_font/*.rb$})
  watch(%r{^lib/(.+)\.rb$})               { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/convert_font/(.+)\.rb$}) 
  watch('spec/spec_helper.rb')  { "spec" }
end

