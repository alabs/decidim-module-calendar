# frozen_string_literal: true

module Decidim
  module Calendar
    module Event
      class << self
        def models
          Calendar.events.keys.filter_map(&:safe_constantize)
        end

        def all(current_organization)
          events = []
          collect_models do |model|
            model
              .all
              .map { |obj| events << present(obj) if obj.organization == current_organization && present(obj).start }
          end
          events
        end

        def present(obj)
          Decidim::Calendar::EventPresenter.new(obj)
        end

        def collect_models
          models.collect do |model|
            if model.has_attribute? :decidim_component_id
              yield model.includes(component: :participatory_space)
            else
              yield model
            end
          end
        end
      end
    end
  end
end
