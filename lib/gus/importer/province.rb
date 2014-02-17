module Gus::Importer

  class ProvinceParser
    include LibXML::XML::SaxParser::Callbacks 

    def initialize(callback)
      @callback = callback
    end

    def on_start_element(element, attributes)  
      @current_tag = element.to_sym

      if @current_tag == :row
        @name = ""
        @uuid = ""
      elsif @current_tag == :col
        @current_attr_name = attributes["name"].to_sym
      end
    end
     
    def on_cdata_block(cdata)
      #puts "on on_cdata_block element: #{cdata}"
    end
     
    def on_characters(chars)
      if @current_tag == :col
        if @current_attr_name == :SYM
          @uuid += chars
        elsif @current_attr_name == :NAZWA
          @name += chars
        end
      end
    end
     
    def on_end_element(element)
      if element.to_sym == :row
        @current_tag = nil

        @callback.call(@name, @uuid)
        @name = ""
        @uuid = ""
      end

      if element.to_sym == :col
        @current_attr_name = nil
      end
    end

    def self.parse(file_path, &block)
      parser = LibXML::XML::SaxParser.file(file_path)
      parser.callbacks = ProvinceParser.new(block)
      parser.parse
    end

  end

end