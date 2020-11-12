# frozen_string_literal: true

module Decidim
  module Calendar
    module Event
      @models = [
        Decidim::Meetings::Meeting.includes(component: :participatory_space),
        Decidim::ParticipatoryProcessStep,
        Decidim::Debates::Debate.includes(component: :participatory_space),
        Decidim::Calendar::ExternalEvent
      ]

      @models = @models << Decidim::Consultation if defined? Decidim::Consultation

      def self.all(current_organization)
        events = []
        @models.collect do |model|
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
