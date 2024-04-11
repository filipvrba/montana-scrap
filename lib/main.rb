require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'json'

require 'app/data'
require 'app/files'

module App
  URL_MONTANA     = 'https://www.montana-cans.com/Montana-BLACK-400ml/263507'
  XPATH_LABELS    = "//ul[@class='color-variant-list']/li//label"
  PATH_SHARE_FILE = File.join(ROOT, 'share', 'montana-black.json')
  
  uri = URI.parse(URL_MONTANA)
  puts('It retrieves data from the server.')
  
  response = Net::HTTP.get_response(uri)
  html = response.body
  doc = Nokogiri::HTML(html)
  
  labels = doc.xpath(XPATH_LABELS)

  puts 'Filters the necessary data.'
  json_sprays = JSON.pretty_generate Data.sprays_data(labels)
  
  is_writted = Files.write(json_sprays, PATH_SHARE_FILE, true)
  if is_writted
    absolute_path_file = PATH_SHARE_FILE.sub(Dir.pwd, '.')
    puts "The data were written to a '#{absolute_path_file}' file."
  else
    puts "Here is the json content:\n" + json_sprays
  end
end