# frozen_string_literal: true

require "decidim/calendar/admin"
require "decidim/calendar/admin_engine"
require "decidim/calendar/engine"
require "decidim/calendar/participatory_space"

module Decidim
  module Calendar
    include ActiveSupport::Configurable

    # Colors per type of event
    # You can generate a nice color palette here: https://coolors.co
    config_accessor :events do
      {
        "Decidim::ParticipatoryProcessStep" => {
          color: "#3A4A9F",
          fontColor: "#fff", # used when "color" is used as background
          id: :participatory_step
        },
        "Decidim::Meetings::Meeting" => {
          color: "#ed1c24",
          fontColor: "#fff",
          id: :meeting
        },
        "Decidim::Calendar::ExternalEvent" => {
          color: "#ed650b",
          fontColor: "#fff",
          id: :external_event
        },
        "Decidim::Debates::Debate" => {
          color: "#099329",
          fontColor: "#fff",
          id: :debate
        },
        # optional events, it is save to define it here even if not installed (will be ignored)
        "Decidim::Consultation" => {
          color: "#92278f",
          fontColor: "#fff",
          id: :consultation
        }
      }
    end

    config_accessor :calendar_options do
      {
        # 0 for sunday, 1 for monday, etc
        firstDay: 1,
        # one of: dayGridMonth,dayGridWeek,dayGridDay,listWeek,listMonth,list
        defaultView: "dayGridMonth",
        # use "true" to get a am/pm format
        hour12: false,
        # several of: dayGridMonth,dayGridWeek,dayGridDay,listWeek,listMonth,listYear
        views: "dayGridMonth,dayGridWeek,dayGridDay,listWeek",
        openInNewWindow: true
      }
    end
  end
end
