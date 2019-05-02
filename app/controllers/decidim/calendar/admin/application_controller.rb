# frozen_string_literal: true

module Decidim
  module Calendar
    module Admin
      class ApplicationController < Decidim::Admin::ApplicationController
        helper_method :events, :event

        def events
          @events ||= Calendar::ExternalEvent.where(organization: current_organization).page(params[:page]).per(15)
        end

        def event
          @event ||= events.find(params[:id])
        end

        def permission_class_chain
          [Decidim::Calendar::Admin::Permissions] + super
        end
      end
    end
  end
end
