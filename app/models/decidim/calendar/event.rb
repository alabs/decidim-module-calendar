# frozen_string_literal: true

module Decidim
  module Calendar
    class Event
      EVENTS = [
        {
          model: Decidim::Meetings::Meeting,
          title: :title,
          start_at: :start_time,
          end_at: :end_time,
          color: "#fabc6c"
        },
        {
          model: Decidim::ParticipatoryProcess,
          title: :title,
          start_at: :start_date,
          end_at: :end_date,
          color: "#238ff7"
        },
        {
          model: Decidim::Calendar::ExternalEvent,
          title: :title,
          start_at: :start_at,
          end_at: :end_at,
          color: "#CCC"
        }
      ].freeze

      def self.all
        EVENTS.collect do |event|
          event[:model]
            .all
            .map do |e|
            {
              title: e.send(event[:title]),
              start_at: e.send(event[:start_at]),
              end_at: e.send(event[:end_at]),
              color: event[:color],
              url: event_url(e)
            }
          end
        end.flatten
      end

      class << self
        private

        def event_url(event)
          return event.url if event.respond_to?(:url)

          Decidim::ResourceLocatorPresenter.new(event).url
        end
      end
    end
  end
end
