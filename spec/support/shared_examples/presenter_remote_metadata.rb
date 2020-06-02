RSpec.shared_examples "presents remote metadata" do
  [:source_metadata_identifier, :source_metadata].each do |method|
    describe "##{method}" do
      it "delegates to solr_document" do
        expect(presenter.solr_document).to receive(method)
        presenter.send(method)
      end
    end
  end
end
