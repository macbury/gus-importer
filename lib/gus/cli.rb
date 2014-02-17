module Gus::Importer
  
  class Cli < Thor
    desc "province file", ""
    def province(file)
      Gus::Importer::ProvinceParser.parse(file) do |name, uuid|
        puts "#{name} => #{uuid}"
      end
    end

    desc "streets file", ""
    def streets(file)
      Gus::Importer::StreetsParser.parse(file) do |street|
        puts "#{street.feature} #{street.second_name} #{street.name} => #{street.uuid}, #{street.city_uuid}"
      end
    end
  end

end