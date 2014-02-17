module Gus::Importer
  
  class Cli < Thor
    desc "province file", ""
    def province(file)
      Gus::Importer::ProvinceParser.parse(file) do |name, uuid|
        puts "#{name} => #{uuid}"
      end
    end
  end

end