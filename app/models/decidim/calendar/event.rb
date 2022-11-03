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
            query = model
            query = query.includes(component: :participatory_space) if query.has_attribute? :decidim_component_id
            # published if responds to it
            query = query.where.not(published_at: nil) if query.has_attribute? :published_at
            # not moderated
            query = query.not_hidden if query.respond_to? :not_hidden
            # not withdrawn
            query = query.except_withdrawn if query.respond_to? :except_withdrawn
            yield query
          end
        end
      end
    end
  end
end
