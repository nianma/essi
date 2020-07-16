# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe MetsXmlEntry, type: :model do
    let(:path) { './spec/fixtures/xml/mets.xml' }
    let(:data) { described_class.read_data(path) }

    before do
      Bulkrax.source_identifier_field_mapping = { 'Bulkrax::MetsXmlEntry' => 'OBJID' }
    end

    describe 'class methods' do
      context '#read_data' do
        it 'reads the data from an xml file' do
          expect(described_class.read_data(path)).to be_a(Nokogiri::XML::Document)
        end
      end

      context '#data_for_entry' do
        it 'retrieves the data and constructs a hash' do
          expect(described_class.data_for_entry(data)).to eq(
            source_identifier: 'http://purl.dlib.indiana.edu/iudl/archives/VAC1741-00310',
            data: '<mets ID=\"VAC1741-00310\" OBJID=\"http://purl.dlib.indiana.edu/iudl/archives/VAC1741-00310\" schemaLocation=\"http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version19/mets.xsd\"> <metsHdr CREATEDATE=\"2013-02-01T10:10:24\"> <agent ROLE=\"CREATOR\" TYPE=\"ORGANIZATION\"> <name>Indiana University Digital Library Program</name> </agent> </metsHdr> <fileSec> <fileGrp USE=\"thumbnail\"> <file GROUPID=\"VAC1741-U-00064-001\" ID=\"VAC1741-U-00064-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"1\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00064-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-002\" ID=\"VAC1741-U-00064-002-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"2\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00064-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-003\" ID=\"VAC1741-U-00064-003-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"3\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00064-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00065-001\" ID=\"VAC1741-U-00065-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"4\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00065-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00066-001\" ID=\"VAC1741-U-00066-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"5\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00066-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-001\" ID=\"VAC1741-U-00067-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"6\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00067-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-002\" ID=\"VAC1741-U-00067-002-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"7\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00067-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-001\" ID=\"VAC1741-U-00068-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"8\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00068-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-002\" ID=\"VAC1741-U-00068-002-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"9\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00068-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-003\" ID=\"VAC1741-U-00068-003-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"10\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00068-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-001\" ID=\"VAC1741-U-00069-001-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"11\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00069-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-002\" ID=\"VAC1741-U-00069-002-thumbnail\" MIMETYPE=\"image/jpeg\" SEQ=\"12\" USE=\"thumbnail\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/thumbnail/VAC1741-U-00069-002\"></FLocat> </file> </fileGrp> <fileGrp USE=\"screen\"> <file GROUPID=\"VAC1741-U-00064-001\" ID=\"VAC1741-U-00064-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"1\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00064-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-002\" ID=\"VAC1741-U-00064-002-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"2\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00064-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-003\" ID=\"VAC1741-U-00064-003-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"3\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00064-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00065-001\" ID=\"VAC1741-U-00065-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"4\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00065-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00066-001\" ID=\"VAC1741-U-00066-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"5\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00066-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-001\" ID=\"VAC1741-U-00067-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"6\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00067-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-002\" ID=\"VAC1741-U-00067-002-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"7\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00067-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-001\" ID=\"VAC1741-U-00068-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"8\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00068-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-002\" ID=\"VAC1741-U-00068-002-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"9\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00068-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-003\" ID=\"VAC1741-U-00068-003-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"10\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00068-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-001\" ID=\"VAC1741-U-00069-001-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"11\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00069-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-002\" ID=\"VAC1741-U-00069-002-screen\" MIMETYPE=\"image/jpeg\" SEQ=\"12\" USE=\"screen\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/screen/VAC1741-U-00069-002\"></FLocat> </file> </fileGrp> <fileGrp USE=\"large\"> <file GROUPID=\"VAC1741-U-00064-001\" ID=\"VAC1741-U-00064-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"1\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00064-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-002\" ID=\"VAC1741-U-00064-002-large\" MIMETYPE=\"image/jpeg\" SEQ=\"2\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00064-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00064-003\" ID=\"VAC1741-U-00064-003-large\" MIMETYPE=\"image/jpeg\" SEQ=\"3\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00064-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00065-001\" ID=\"VAC1741-U-00065-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"4\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00065-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00066-001\" ID=\"VAC1741-U-00066-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"5\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00066-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-001\" ID=\"VAC1741-U-00067-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"6\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00067-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067-002\" ID=\"VAC1741-U-00067-002-large\" MIMETYPE=\"image/jpeg\" SEQ=\"7\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00067-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-001\" ID=\"VAC1741-U-00068-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"8\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00068-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-002\" ID=\"VAC1741-U-00068-002-large\" MIMETYPE=\"image/jpeg\" SEQ=\"9\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00068-002\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068-003\" ID=\"VAC1741-U-00068-003-large\" MIMETYPE=\"image/jpeg\" SEQ=\"10\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00068-003\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-001\" ID=\"VAC1741-U-00069-001-large\" MIMETYPE=\"image/jpeg\" SEQ=\"11\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00069-001\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069-002\" ID=\"VAC1741-U-00069-002-large\" MIMETYPE=\"image/jpeg\" SEQ=\"12\" USE=\"large\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/large/VAC1741-U-00069-002\"></FLocat> </file> </fileGrp> <fileGrp USE=\"printable\"> <file GROUPID=\"VAC1741-U-00064\" ID=\"VAC1741-U-00064-printable\" MIMETYPE=\"application/pdf\" SEQ=\"1\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00064\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00065\" ID=\"VAC1741-U-00065-printable\" MIMETYPE=\"application/pdf\" SEQ=\"2\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00065\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00066\" ID=\"VAC1741-U-00066-printable\" MIMETYPE=\"application/pdf\" SEQ=\"3\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00066\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00067\" ID=\"VAC1741-U-00067-printable\" MIMETYPE=\"application/pdf\" SEQ=\"4\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00067\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00068\" ID=\"VAC1741-U-00068-printable\" MIMETYPE=\"application/pdf\" SEQ=\"5\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00068\"></FLocat> </file> <file GROUPID=\"VAC1741-U-00069\" ID=\"VAC1741-U-00069-printable\" MIMETYPE=\"application/pdf\" SEQ=\"6\" USE=\"printable\"> <FLocat LOCTYPE=\"PURL\" href=\"http://purl.dlib.indiana.edu/iudl/archives/printable/VAC1741-U-00069\"></FLocat> </file> </fileGrp> </fileSec> <structMap TYPE=\"logical\"> <div TYPE=\"archivalcomponent\"> <mets: ID=\"VAC1741-U-00064\" ORDER=\"1\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00064-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00064-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00064-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00064-001-large\"></fptr> </div> <div ORDER=\"2\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00064-002-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00064-002-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00064-002-large\"></fptr> </div> <div ORDER=\"3\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00064-003-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00064-003-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00064-003-large\"></fptr> </div> </mets:> <div ID=\"VAC1741-U-00065\" ORDER=\"2\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00065-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00065-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00065-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00065-001-large\"></fptr> </div> </div> <div ID=\"VAC1741-U-00066\" ORDER=\"3\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00066-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00066-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00066-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00066-001-large\"></fptr> </div> </div> <div ID=\"VAC1741-U-00067\" ORDER=\"4\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00067-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00067-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00067-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00067-001-large\"></fptr> </div> <div ORDER=\"2\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00067-002-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00067-002-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00067-002-large\"></fptr> </div> </div> <div ID=\"VAC1741-U-00068\" ORDER=\"5\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00068-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00068-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00068-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00068-001-large\"></fptr> </div> <div ORDER=\"2\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00068-002-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00068-002-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00068-002-large\"></fptr> </div> <div ORDER=\"3\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00068-003-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00068-003-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00068-003-large\"></fptr> </div> </div> <div ID=\"VAC1741-U-00069\" ORDER=\"6\" TYPE=\"archivalitem\"> <fptr FILEID=\"VAC1741-U-00069-printable\"></fptr> <div ORDER=\"1\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00069-001-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00069-001-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00069-001-large\"></fptr> </div> <div ORDER=\"2\" TYPE=\"page\"> <fptr FILEID=\"VAC1741-U-00069-002-thumbnail\"></fptr> <fptr FILEID=\"VAC1741-U-00069-002-screen\"></fptr> <fptr FILEID=\"VAC1741-U-00069-002-large\"></fptr> </div> </div> </div> </structMap></mets>',
            collection: [],
            children: []
          )
        end
      end
    end

    describe '#build' do
      subject(:xml_entry) { described_class.new(importerexporter: importer) }
      let(:raw_metadata) { described_class.data_for_entry(data) }
      let(:importer) { FactoryBot.build(:bulkrax_importer_xml) }
      let(:object_factory) { instance_double(ObjectFactory) }

      before do
        Bulkrax.default_work_type = 'Work'
        Bulkrax.field_mappings.merge!(
          'Bulkrax::XmlParser' => {
            'title' => { from: ['VAC1741-00310'] }
          }
        )
      end

      context 'with raw_metadata' do
        before do
          xml_entry.raw_metadata = raw_metadata
          allow(ObjectFactory).to receive(:new).and_return(object_factory)
          allow(object_factory).to receive(:run!).and_return(instance_of(Work))
          allow(User).to receive(:batch_user)
        end

        it 'succeeds' do
          xml_entry.build
          expect(xml_entry.status).to eq('succeeded')
        end

        it 'builds entry' do
          xml_entry.build
          expect(xml_entry.parsed_metadata).to eq("file" => nil, "rights_statement" => [nil], "source" => ["3456012"], "title" => ["Single XML Entry"], "visibility" => "open")
        end

        it 'does not add unsupported fields' do
          xml_entry.build
          expect(xml_entry.parsed_metadata).not_to include('abstract')
          expect(xml_entry.parsed_metadata).not_to include('Lorem ipsum dolor sit amet.')
        end
      end

      context 'without raw_metadata' do
        before do
          xml_entry.raw_metadata = nil
        end

        it 'fails' do
          xml_entry.build
          expect(xml_entry.status).to eq('failed')
        end
      end
    end

    xit '#add_logical_structure' do
      # described_class.build_metadata
      logical_structure = described_class.parsed_metadata['logical_structure']
      expect(logical_structure['label']).to eq('VAC1741-U-00064')
      expect(logical_structure['nodes'].first['proxy']).to eq('VAC1741-U-00064-001')
    end
  end
end
