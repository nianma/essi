# Generated via
#  `rails generate hyrax:work BibRecord`
require 'rails_helper'

RSpec.describe Hyrax::BibRecordPresenter do
  subject { described_class.new(double, double) }

  include_examples "presents remote metadata" do
    let(:presenter) { subject }
  end
end
