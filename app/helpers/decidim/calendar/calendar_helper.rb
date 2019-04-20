# frozen_string_literal: true

module Decidim
  module Calendar
    module CalendarHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper
      def calendar_event(event)
        %({
          "title": "#{translated_attribute event[:title]}",
          "start": "#{event[:start_at].strftime("%FT%R")}",
          "end": "#{event[:end_at].strftime("%FT%R")}",
          "color": "#{event[:color]}"
        })
      end
    end
  end
end
