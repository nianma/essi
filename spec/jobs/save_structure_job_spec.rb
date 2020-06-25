require 'spec_helper'
require 'rails_helper'

describe SaveStructureJob do

  let(:paged_resource) { FactoryBot.create(:paged_resource_with_one_image) }
  let(:structure) { File.read(Rails.root.join('spec', 'fixtures', 'structure.json')) }

  context "save structure job" do
    it "saves the structure successfully" do
      expect(paged_resource.logical_order.order).to be_empty
      described_class.perform_now(paged_resource, structure)
      expect(paged_resource.logical_order.order).to be
    end
  end
end
