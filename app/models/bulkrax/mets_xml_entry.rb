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
      Nokogiri::XML(open(path))
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

    def source_identifier
      @source_identifier ||= self.raw_metadata['source_identifier']
    end
    
    def record
      @record ||= IuMetadata::METSRecord.new(source_identifier, raw_metadata['data'])
    end

    def build_metadata
      raise StandardError, 'Record not found' if record.nil?
      raise StandardError, 'Missing source identifier' if source_identifier.blank?
      self.parsed_metadata = {}
      self.parsed_metadata['admin_set_id'] = self.importerexporter.admin_set_id
      self.parsed_metadata[Bulkrax.system_identifier_field] = [source_identifier]
      self.parsed_metadata['work_type'] = ['PagedResource']

      record.attributes.each do |k,v|
        add_metadata(k, v) unless v.blank?
      end
      add_title
      add_visibility
      add_rights_statement
      self.parsed_metadata['remote_files'] = record.files
      self.parsed_metadata['structure'] = record.structure #add_logical_structure
      add_collections
      add_local
      raise StandardError, "title is required" if self.parsed_metadata['title'].blank?
      self.parsed_metadata
    end

    def add_title
      self.parsed_metadata['title'] = [parser.parser_fields['title']] || [record.record_id]
    end
  end
end

