# frozen_string_literal: true

module Decidim
  module Calendar
    class CalendarController < Decidim::Calendar::ApplicationController
      helper Decidim::Calendar::CalendarHelper
      include ParticipatorySpaceContext
      def index; end

      private

      def current_participatory_space_manifest
        @current_participatory_space_manifest ||= Decidim.find_participatory_space_manifest(:calendar)
      end
    end
  end
end
