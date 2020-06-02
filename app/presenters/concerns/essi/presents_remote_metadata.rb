module ESSI
  module PresentsRemoteMetadata
    delegate :source_metadata_identifier, :source_metadata, to: :solr_document
  end
end
