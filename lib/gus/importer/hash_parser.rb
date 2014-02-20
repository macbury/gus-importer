module Gus::Importer

  class HashParser
    include LibXML::XML::SaxParser::Callbacks 

    def initialize(callback)
      @callback = callback
      @hash     = {}
    end

    def on_start_element(element, attributes)  
      @current_tag = element.to_sym

      if @current_tag == :row
        @hash = {}
      elsif @current_tag == :col
        @current_attr_name = attributes["name"].to_sym
      end
    end
     
    def on_cdata_block(cdata)
      #puts "on on_cdata_block element: #{cdata}"
    end
     
    def on_characters(chars)
      if @current_tag == :col && !@current_attr_name.nil?
        @hash[@current_attr_name] ||= ""
        @hash[@current_attr_name] += chars
      end
    end
     
    def on_end_element(element)
      if element.to_sym == :row
        @current_tag = nil

        @callback.call(@hash)
        @hash = {}
      end

      if element.to_sym == :col
        @current_attr_name = nil
      end
    end

    def self.parse(file_path, &block)
      parser = LibXML::XML::SaxParser.file(file_path)
      parser.callbacks = HashParser.new(block)
      parser.parse
    end

  end

end