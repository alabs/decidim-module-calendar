# frozen_string_literal: true

module Decidim
  module Calendar
    module CalendarHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper
      def calendar_resource(name)
        %({
          "id": "#{name}",
          "title": "#{I18n.t(name, scope: "decidim.calendar.index.filters")}"
        })
      end

      def render_events(events)
        events.collect { |event| calendar_event(event) }.to_json
      end

      def calendar_event(event)
        {
          title: translated_attribute(event.full_title),
          start: event.start.strftime("%FT%R"),
          end: event.finish.strftime("%FT%R"),
          color: event.color,
          url: event.link,
          resourceId: event.type,
          allDay: event.all_day?,
          subtitle: (translated_attribute(event.subtitle) unless event.subtitle.empty?)
        }.compact
      end

      def participatory_gantt(event)
        %({
          "id": "#{event.full_id}",
          "name": "#{translated_attribute event.full_title}",
          "start": "#{event.start.strftime("%FT%R")}",
          "dependencies": "#{event.parent}",
          "end": "#{event.finish.strftime("%FT%R")}"
        })
      end
    end
  end
end
