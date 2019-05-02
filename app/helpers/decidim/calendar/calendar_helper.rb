# frozen_string_literal: true

module Decidim
  module Calendar
    module CalendarHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper
      def calendar_event(event)
        %({
          "title": "#{translated_attribute event.full_title}",
          "start": "#{event.start.strftime("%FT%R")}",
          "end": "#{event.end.strftime("%FT%R")}",
          "color": "#{event.color}",
          "url": "#{event.link}"
        })
      end

      def participatory_gantt(event)
        %({
          "id": "#{event.id}",
          "name": "#{translated_attribute event.full_title}",
          "start": "#{event.start.strftime("%FT%R")}",
          "end": "#{event.end.strftime("%FT%R")}"
        })
      end
    end
  end
end
