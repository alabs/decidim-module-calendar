# frozen_string_literal: true

require "spec_helper"

describe "manage help section", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization:) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.help_sections_path
  end

  it "displays help section for calendar" do
    Capybara.ignore_hidden_elements = false
    expect(page).to have_content("Calendars")
    Capybara.ignore_hidden_elements = true
  end
end
