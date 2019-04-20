# frozen_string_literal: true

module Decidim
  module Calendar
    class Event
      EVENTS = [
        [Decidim::Meetings::Meeting, :title, :start_time, :end_time, "#fabc6c"],
        [Decidim::ParticipatoryProcess, :title, :start_date, :end_date, "#238ff7"]
      ].freeze

      def self.all
        collector = []
        EVENTS.each do |event|
          collector << event[0]
                       .all
                       .each.map do |e|
            {
              title: e.send(event[1]),
              start_at: e.send(event[2]),
              end_at: e.send(event[3]),
              color: event[4]
            }
          end
        end
        collector.flatten
      end
    end
  end
end
