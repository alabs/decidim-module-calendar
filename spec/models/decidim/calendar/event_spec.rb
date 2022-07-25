# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Calendar
    describe Event do
      subject { described_class }

      let(:organization) { create :organization }
      let!(:event) { create(:external_event, organization: organization) }
      let!(:participatory_process) { create(:participatory_process, organization: organization) }
      let!(:component) { create(:meeting_component, participatory_space: participatory_process) }
      let!(:meeting) { create(:meeting, component: component) }
      let!(:another_event) { create(:external_event) }
      let!(:another_meeting) { create(:meeting) }

      it "returns models" do
        expect(subject.models).to include(Decidim::Meetings::Meeting)
        expect(subject.models).to include(Decidim::ParticipatoryProcessStep)
        expect(subject.models).to include(Decidim::Debates::Debate)
        expect(subject.models).to include(Decidim::Calendar::ExternalEvent)
        expect(subject.models).to include(Decidim::Consultation)
      end

      it "returns events" do
        expect(subject.all(organization)).to include(event)
        expect(subject.all(organization)).not_to include(another_event)
        expect(subject.all(organization)).to include(meeting)
        expect(subject.all(organization)).not_to include(another_meeting)
      end

      it "returns a presenter" do
        expect(subject.present(event)).to be_a(Decidim::Calendar::EventPresenter)
      end

      context "when a class is not defined" do
        let(:custom_config) do
          {
            "Decidim::Meetings::Meeting" => {
              color: "#ed1c24",
              fontColor: "#fff",
              id: :meeting
            },
            "AnotherNamespace::AnotherThing" => {
              color: "#bbb",
              fontColor: "#fff",
              id: :another_thing
            }
          }
        end

        before do
          allow(::Decidim::Calendar).to receive(:events).and_return(custom_config)
        end

        it "returns only available models" do
          expect(subject.models.count).to eq(1)
          expect(subject.models.first).to eq(Decidim::Meetings::Meeting)
        end

        it "returns only available events" do
          expect(subject.all(organization)).to eq([meeting])
        end
      end

      context "when a class is not configure" do
        let(:custom_config) do
          {
            "Decidim::Meetings::Meeting" => {
              color: "#ed1c24",
              fontColor: "#fff",
              id: :meeting
            }
          }
        end

        before do
          allow(::Decidim::Calendar).to receive(:events).and_return(custom_config)
        end

        it "does not return the model" do
          expect(subject.models).to include(Decidim::Meetings::Meeting)
          expect(subject.models).not_to include(Decidim::Calendar::ExternalEvent)
        end

        it "does not return the event" do
          expect(subject.all(organization)).not_to include(event)
          expect(subject.all(organization)).to include(meeting)
        end
      end
    end
  end
end
