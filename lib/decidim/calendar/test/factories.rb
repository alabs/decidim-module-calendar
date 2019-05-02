# frozen_string_literal: true

FactoryBot.define do
  factory :external_event, class: Decidim::Calendar::ExternalEvent do
    title { generate_localized_title }
    start_at { Date.current }
    end_at { Date.current + 1.day }
    url { Faker::Internet.url }
    organization { build(:organization) }
    author { build(:user, organization: organization) }
  end
end
