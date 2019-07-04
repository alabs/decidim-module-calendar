# frozen_string_literal: true

require "spec_helper"

describe "User interact with the calendar", type: :system do
  let!(:organization) { create(:organization) }
  let!(:user) { create :user, :confirmed, organization: organization }
  let!(:participatory_process) { create :participatory_process, :with_steps, :active, :published, organization: organization }
  let!(:component) { create :meeting_component, participatory_space: participatory_process }
  let!(:meeting) { create :meeting, component: component }

  before do
    switch_to_host(organization.host)
  end

  context "with calendar" do
    before do
      visit decidim_calendar.calendar_index_path
    end

    it "show the calendar" do
      expect(page).to have_i18n_content("calendar")
    end

    it "show a item in calendar" do
      expect(page).to have_i18n_content(meeting.title)
    end
  end

  context "with gantt" do
    before do
      visit decidim_calendar.calendar_gantt_path
    end

    it "show the gantt" do
      expect(page).to have_i18n_content(participatory_process.title)
    end
  end

  context "with ical", driver: :rack_test do
    before do
      visit decidim_calendar.calendar_ical_path
    end

    it "download the ICAL" do
      expect(page.response_headers["Content-Type"]).to match "text/calendar"
      expect(page.response_headers["Content-Disposition"]).to match(/^attachment/)
      expect(page).to have_i18n_content(participatory_process.title)
    end
  end
end
