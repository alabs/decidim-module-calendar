# frozen_string_literal: true

module Decidim
  module Calendar
    module Event

      if defined? Decidim::Consultation
        MODELS = [
          Decidim::Meetings::Meeting,
          Decidim::ParticipatoryProcessStep,
          Decidim::Debates::Debate,
          Decidim::Consultation,
          Decidim::Calendar::ExternalEvent
        ].freeze
      else
        MODELS = [
          Decidim::Meetings::Meeting,
          Decidim::ParticipatoryProcessStep,
          Decidim::Debates::Debate,
          Decidim::Calendar::ExternalEvent
        ].freeze
      end

      def self.all(current_organization)
        events = []
        MODELS.collect do |model|
          model
            .all
            .map { |obj| events << present(obj) if obj.organization == current_organization && present(obj).start }
        end
        events
      end

      def self.present(obj)
        Decidim::Calendar::EventPresenter.new(obj)
      end
    end
  end
end
