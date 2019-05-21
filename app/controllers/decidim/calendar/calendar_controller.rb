# frozen_string_literal: true

module Decidim
  module Calendar
    class CalendarController < Decidim::Calendar::ApplicationController
      helper Decidim::Calendar::CalendarHelper
      include ParticipatorySpaceContext
      layout "calendar"
      def index
        @events = Event.all(current_organization)
        @resources = %w(consultation debate external_event meeting participatory_step)
      end

      def gantt
        @events = Decidim::ParticipatoryProcessStep.where.not(start_date: nil).order(decidim_participatory_process_id: :asc, position: :asc, start_date: :asc).map do |p|
          Decidim::Calendar::EventPresenter.new(p) if p.organization == current_organization
        end
      end

      def ical
        filename = "#{current_organization.name.parameterize}-calendar"
        response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.ical"'
        render plain: GeneralCalendar.for(current_organization), content_type: "text/calendar"
      end

      private

      def current_participatory_space_manifest
        @current_participatory_space_manifest ||= Decidim.find_participatory_space_manifest(:calendar)
      end
    end
  end
end
