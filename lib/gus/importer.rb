require "gus/importer/version"
require "uri"
require "tempfile"
require "net/http"
require "libxml"
require "gus/importer/hash_parser"
require "pry"
module Gus
  module Importer
    
    def self.download(url, to_file)
      uri = URI.parse(url)

      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri.request_uri

        http.request(request) do |response|
          open(to_file, 'w') do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    end

  end
end
