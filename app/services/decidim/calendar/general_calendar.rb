# frozen_string_literal: true

module Decidim
  module Calendar
    class GeneralCalendar < Decidim::Meetings::Calendar::BaseCalendar
      def events
        Event.all(resource).map do |event|
          EventToIcal.new(event).to_ical
        end.join
      end
    end
  end
end
