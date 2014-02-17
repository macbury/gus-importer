module Gus::Importer

  class StreetsParser
    include LibXML::XML::SaxParser::Callbacks 

    def initialize(callback)
      @callback = callback
      @street   = nil
    end

    def on_start_element(element, attributes)  
      @current_tag = element.to_sym

      if @current_tag == :row
        @street = Street.new
      elsif @current_tag == :col
        @current_attr_name = attributes["name"].to_sym
      end
    end
     
    def on_cdata_block(cdata)
      #puts "on on_cdata_block element: #{cdata}"
    end
     
    def on_characters(chars)
      if @current_tag == :col
        if @current_attr_name == :CECHA
          @street.feature += chars
        elsif @current_attr_name == :SYM
          @street.city_uuid += chars
        elsif @current_attr_name == :SYM_UL
          @street.uuid += chars
        elsif @current_attr_name == :NAZWA_1
          @street.name += chars
        elsif @current_attr_name == :NAZWA_2
          @street.second_name += chars
        end
      end
    end
     
    def on_end_element(element)
      if element.to_sym == :row
        @current_tag = nil

        @callback.call(@street.get!)
        @street = nil
      end

      if element.to_sym == :col
        @current_attr_name = nil
      end
    end

    def self.parse(file_path, &block)
      parser = LibXML::XML::SaxParser.file(file_path)
      parser.callbacks = StreetsParser.new(block)
      parser.parse
    end

  end

  class Street
    attr_accessor :name, :uuid, :city_uuid, :feature, :second_name

    def initialize
      self.second_name       = ""
      self.name       = ""
      self.uuid       = ""
      self.city_uuid  = ""
      self.feature    = ""
    end

    def get!
      self.second_name.strip!
      self.name.strip!
      self.uuid.strip!
      self.city_uuid.strip!
      self.feature.strip!

      self.uuid      = self.uuid.to_i
      self.city_uuid = self.city_uuid.to_i
      self
    end
  end
end