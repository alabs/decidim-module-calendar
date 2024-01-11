# frozen_string_literal: true

require "spec_helper"

describe "manage external events", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization:) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_calendar.external_events_path
  end

  describe "creating a event" do
    before do
      within ".item_show__header" do
        click_on "New external event"
      end
    end

    it "create a new external event" do
      start_time = Time.current
      end_time = 2.days.from_now

      fill_in "external_event[start_at]", with: start_time.strftime("%Y-%m-%dT%H:%M")
      fill_in "external_event[end_at]", with: end_time.strftime("%Y-%m-%dT%H:%M")

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

      within ".table-list" do
        expect(page).to have_css("td", text: "Example Event")
        expect(page).to have_css("td", text: "https://example.org")
      end
    end
  end

  describe "external event actions" do
    let!(:external_event) { create(:external_event, organization:) }

    before do
      visit current_path
    end

    it "delete a event" do
      within "tr", text: translated(external_event.title) do
        accept_confirm { click_on "Delete" }
      end

      expect(page).to have_admin_callout("successfully")

      within "#events" do
        expect(page).to have_no_content(translated(external_event.title))
      end
    end

    it "update a event" do
      within "tr", text: translated(external_event.title) do
        click_on "Edit"
      end

      start_time = Time.current
      end_time = 2.days.from_now

      fill_in "external_event[start_at]", with: start_time.strftime("%Y-%m-%dT%H:%M")
      fill_in "external_event[end_at]", with: end_time.strftime("%Y-%m-%dT%H:%M")

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
