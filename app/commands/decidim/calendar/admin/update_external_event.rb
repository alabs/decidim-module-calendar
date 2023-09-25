# frozen_string_literal: true

module Decidim
  module Calendar
    module Admin
      class UpdateExternalEvent < Decidim::Command
        def initialize(external_event, form)
          @external_event = external_event
          @form = form
        end

        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            update_external_event!
          end

          broadcast(:ok, @event)
        end

        private

        attr_reader :external_event, :form

        def update_external_event!
          external_event.update! attributes
        end

        def attributes
          {
            title: form.title,
            start_at: form.start_at,
            end_at: form.end_at,
            url: form.url,
            organization: current_organization,
            author: current_user
          }
        end
      end
    end
  end
end
