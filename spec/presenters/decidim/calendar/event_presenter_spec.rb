# frozen_string_literal: true

require "spec_helper"

module Decidim::Calendar
  describe EventPresenter, type: :helper do
    let(:event) { build(:external_event) }

    describe "#url" do
      subject { described_class.new(event).url }

      it { is_expected.not_to be_empty }
    end
  end
end
