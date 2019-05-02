# frozen_string_literal: true

module Decidim
  module Calendar
    module Event
      MODELS = [
        Decidim::Meetings::Meeting,
        Decidim::ParticipatoryProcessStep,
        Decidim::Calendar::ExternalEvent
      ].freeze

      def self.all(current_organization)
        events = []
        MODELS.collect do |model|
          model
            .all
            .map { |obj| events << Decidim::Calendar::EventPresenter.new(obj) if obj.organization == current_organization }
        end
        events
      end
    end
  end
end
