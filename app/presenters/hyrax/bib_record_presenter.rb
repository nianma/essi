# Generated via
#  `rails generate hyrax:work BibRecord`
module Hyrax
  class BibRecordPresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsNumPages
    include ESSI::PresentsOCR
    include ESSI::PresentsRemoteMetadata
    include ESSI::PresentsStructure
    delegate :series, to: :solr_document
  end
end
