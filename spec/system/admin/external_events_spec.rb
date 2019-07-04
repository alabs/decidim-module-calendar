# frozen_string_literal: true

require "spec_helper"

describe "manage external events" do
  let(:organization) { create :organization }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_calendar.external_events_path
  end

  describe "creating a event" do
    before do
      within ".card-divider" do
        click_link "New"
      end
    end

    it "create a new external event" do
      execute_script("$('#external_event_start_at').focus()")
      page.find(".datepicker-dropdown .day", text: "12").click
      page.find(".datepicker-dropdown .hour", text: "10:00").click
      page.find(".datepicker-dropdown .minute", text: "10:50").click

      execute_script("$('#external_event_end_at').focus()")
      page.find(".datepicker-dropdown .day", text: "12").click
      page.find(".datepicker-dropdown .hour", text: "12:00").click
      page.find(".datepicker-dropdown .minute", text: "12:50").click

      within ".new_event" do
        fill_in_i18n(
          :external_event_title,
          "#external_event-title-tabs",
          en: "Example Event",
          es: "Evento de ejemplo",
          ca: "Evento de ejemplo"
        )

        fill_in :external_event_url, with: "https://example.org"

        find("*[type=submit]").click
      end

      expect(page).to have_admin_callout("successfully")

      within ".container" do
        expect(page).to have_current_path decidim_admin_calendar.external_events_path
        expect(page).to have_content("Example Event")
      end
    end
  end

  describe "external event actions" do
    let!(:external_event) { create(:external_event, organization: organization) }

    before do
      visit current_path
    end

    it "delete a event" do
      within find("tr", text: translated(external_event.title)) do
        accept_confirm { click_link "Delete" }
      end

      expect(page).to have_admin_callout("successfully")

      within "#events" do
        expect(page).to have_no_content(translated(external_event.title))
      end
    end

    it "update a event" do
      within find("tr", text: translated(external_event.title)) do
        click_link "Edit"
      end

      execute_script("$('#external_event_start_at').focus()")
      page.find(".datepicker-dropdown .day", text: "12").click
      page.find(".datepicker-dropdown .hour", text: "10:00").click
      page.find(".datepicker-dropdown .minute", text: "10:50").click

      execute_script("$('#external_event_end_at').focus()")
      page.find(".datepicker-dropdown .day", text: "12").click
      page.find(".datepicker-dropdown .hour", text: "12:00").click
      page.find(".datepicker-dropdown .minute", text: "12:50").click

      within ".edit_event" do
        fill_in_i18n(
          :external_event_title,
          "#external_event-title-tabs",
          en: "Edited Example Event",
          es: "Edited Evento de ejemplo",
          ca: "Edited Evento de ejemplo"
        )
        fill_in :external_event_url, with: "https://example.org"

        find("*[type=submit]").click
      end

      expect(page).to have_admin_callout("successfully")
      within "#events" do
        expect(page).to have_content("Edited Example Event")
      end
    end
  end
end
