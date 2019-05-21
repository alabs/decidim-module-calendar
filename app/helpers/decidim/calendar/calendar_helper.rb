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
          start: (event.start.strftime("%FT%R") unless event.start.nil?),
          end: (event.finish.strftime("%FT%R") unless event.finish.nil?),
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

      def participatory_space_wrapper(&block)
        content_tag :main, class: "wrapper" do
          concat(capture(&block))
        end
      end

      def extended_navigation_bar(items, max_items: 5)
        return unless items.any?
        extra_items = []
        active_item = items.find { |item| item[:active] }

        render partial: "decidim/shared/extended_navigation_bar", locals: {
          items: items,
          extra_items: extra_items,
          active_item: active_item,
          max_items: 5
        }
      end
    end
  end
end
