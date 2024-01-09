# frozen_string_literal: true

module Decidim
  module Calendar
    module CalendarHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper

      def available_events
        @available_events ||= Calendar.events.select { |key, _item| key.safe_constantize }
      end

      def render_events(events)
        events.collect { |event| calendar_event(event) }.to_json
      end

      def calendar_event(event)
        {
          title: translated_attribute(event.full_title),
          start: (event.start.strftime("%FT%R") unless event.start.nil?),
          end: (event.finish.strftime("%FT%R") unless event.finish.nil?),
          hour: event.hour,
          backgroundColor: event.color,
          textColor: event.font_color,
          url: event.link,
          resourceId: event.type,
          allDay: event.all_day?,
          classNames: ["calendar-event-#{event.type}#{event.hour ? " has-hour" : " all-day"}"],
          subtitle: (translated_attribute(event.subtitle) unless event.subtitle.empty?)
        }.compact
      end

      def participatory_gantt(event)
        {
          id: event.full_id,
          name: "#{translated_attribute event.full_title} - #{translated_attribute event.subtitle}",
          start: event.start.strftime("%FT%R"),
          dependencies: event.parent,
          end: event.finish.strftime("%FT%R")
        }
      end
    end
  end
end
