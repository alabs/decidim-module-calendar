# frozen_string_literal: true

module Decidim
  module Calendar
    module Admin
      class ExternalEventsController < Admin::ApplicationController
        helper_method :current_external_event, :external_events

        def index
          enforce_permission_to :read, :external_event
        end

        def new
          enforce_permission_to :create, :external_event
          @form = external_event_form.instance
        end

        def edit
          enforce_permission_to :update, :external_event, external_event: current_external_event
          @form = external_event_form.from_model(current_external_event)
        end

        def create
          enforce_permission_to :create, :external_event
          @form = external_event_form.from_params(params)

          CreateExternalEvent.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("create.success", scope: "decidim.calendar.admin.external_events")
              redirect_to external_events_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("create.invalid", scope: "decidim.calendar.admin.external_events")
              render action: "new"
            end
          end
        end

        def update
          enforce_permission_to :update, :external_event, external_event: current_external_event
          @form = external_event_form
                  .from_params(params, external_event_id: current_external_event.id)

          UpdateExternalEvent.call(current_external_event, @form) do
            on(:ok) do
              flash[:notice] = I18n.t("update.success", scope: "decidim.calendar.admin.external_events")
              redirect_to external_events_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("update.invalid", scope: "decidim.calendar.admin.external_events")
              render :edit
            end
          end
        end

        def destroy
          enforce_permission_to :destroy, :external_event, external_event: current_external_event
          DestroyExternalEvent.call(current_external_event) do
            on(:ok) do
              flash[:notice] = I18n.t("destroy.success", scope: "decidim.calendar.admin.external_events")
              redirect_to external_events_path
            end
          end
        end

        private

        def external_event_form
          form(ExternalEventForm)
        end

        def external_events
          @external_events ||= Calendar::ExternalEvent.where(organization: current_organization).page(params[:page]).per(15)
        end

        def current_external_event
          @current_external_event ||= external_events.find(params[:id])
        end
      end
    end
  end
end
