module Gus::Importer
  
  class Cli < Thor
    desc "parse file", ""
    def parse(file)
      Gus::Importer::HashParser.parse(file) do |object|
        puts object.inspect
      end
    end

  end

end