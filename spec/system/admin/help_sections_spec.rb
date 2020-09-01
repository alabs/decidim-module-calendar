# frozen_string_literal: true

require "spec_helper"

describe "manage calendar's module help section" do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    Capybara.ignore_hidden_elements = false
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.help_sections_path
  end
  
  it "displays help sections for calendar" do
    expect(page).to have_content("Calendars")
  end
end
