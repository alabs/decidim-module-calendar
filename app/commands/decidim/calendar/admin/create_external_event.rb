# frozen_string_literal: true

module Decidim
  module Calendar
    module Admin
      class CreateExternalEvent < Decidim::Command
        def initialize(form)
          @form = form
        end

        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            create_event
          end

          broadcast(:ok, @event)
        end

        private

        attr_reader :form

        def create_event
          @event = ExternalEvent.create(
            organization: form.current_organization,
            title: form.title,
            start_at: form.start_at,
            end_at: form.end_at,
            url: form.url,
            author: form.current_user
          )
        end
      end
    end
  end
end
