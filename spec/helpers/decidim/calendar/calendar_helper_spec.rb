# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Calendar
    describe CalendarHelper do
      subject { helper.calendar_event(EventPresenter.new(event)) }

      let(:event) { create(:external_event) }

      describe "event_hash" do
        it { is_expected.to include(:url, :title) }
      end
    end
  end
end
