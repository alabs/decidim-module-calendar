# frozen_string_literal: true

require "decidim/calendar/admin"
require "decidim/calendar/admin_engine"
require "decidim/calendar/engine"
require "decidim/calendar/participatory_space"

module Decidim
  module Calendar
    include ActiveSupport::Configurable

    # Colors per type of event
    config_accessor :events do
      {
        "Decidim::ParticipatoryProcessStep" => {
          color: "#3A4A9F",
          id: :participatory_step
        },
        "Decidim::Meetings::Meeting" => {
          color: "#ed1c24",
          id: :meeting
        },
        "Decidim::Calendar::ExternalEvent" => {
          color: "#ed650b",
          id: :external_event
        },
        "Decidim::Debates::Debate" => {
          color: "#099329",
          id: :debate
        },
        "Decidim::Consultation" => {
          color: "#92278f",
          id: :consultation
        }
      }
    end
  end
end
