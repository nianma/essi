# frozen_string_literal: true

require 'nokogiri'
module Bulkrax
  # Generic XML Entry
  class MetsXmlEntry < Entry
    serialize :raw_metadata, JSON

    def self.fields_from_data(data); end

    def self.read_data(path)
      # This doesn't cope with BOM sequences:
      # Nokogiri::XML(open(path), nil, 'UTF-8').remove_namespaces!
      Nokogiri::XML(open(path)).remove_namespaces!
    end

    def self.data_for_entry(data)
      collections = []
      children = []
      
      source_identifier = data.attributes[source_identifier_field].text
      return {
        source_identifier: source_identifier,
        data:
          data.to_xml(
            encoding: 'UTF-8',
            save_with:
              Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
          ).delete("\n").delete("\t").squeeze(' '), # Remove newlines, tabs, and extra whitespace
        collection: collections,
        children: children
      }
    end

    # def self.matcher_class; end

    def source_identifier
      @source_identifier ||= self.raw_metadata['source_identifier']
    end
    
    def record
      #@record ||= IuMetadata::METSRecord.new(source_identifier, raw_metadata['data'])
      @record ||= Nokogiri::XML(self.raw_metadata['data'], nil, 'UTF-8')
    end

    def self.build_metadata 
      raise StandardError, 'Record not found' if record.nil?
      raise StandardError, 'Missing source identifier' if source_identifier.blank?
      self.parsed_metadata = {}
      self.parsed_metadata[Bulkrax.system_identifier_field] = [source_identifier]
      #record.attributes.each do |k,v|
      #  add_metadata(k, v) unless v.blank?
      #end
      xml_elements.each do |element_name|
        elements = record.xpath("//*[name()='#{element_name}']")
        next if elements.blank?
        elements.each do |el|
          el.children.map(&:content).each do |content|
            add_metadata(element_name, content) unless content.blank?
          end
        end
      end
      add_visibility
      add_rights_statement
      add_logical_structure
      add_collections
      # self.parsed_metadata['file'] = self.raw_metadata['file']

      add_local
      raise StandardError, "title is required" if self.parsed_metadata['title'].blank?
      self.parsed_metadata
    end

    # Grab the class from the real parser
    def self.xml_elements
      Bulkrax.field_mappings[self.importerexporter.parser_klass].map do |_k, v|
        v[:from]
      end.flatten.compact.uniq
    end

    def self.add_logical_structure
      # TODO: deal with files
      # TODO: deal with structure
      # This method will convert the logical structure into a ruby hash.
      # Doing so should set parsed_metadata to the correct value for hyrax to ingest and create the manifest
    end
  end
end

