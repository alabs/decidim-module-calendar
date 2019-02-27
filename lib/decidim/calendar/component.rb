# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:calendar) do |component|
  component.admin_engine = Decidim::Calendar::AdminEngine
  component.engine = Decidim::Calendar::Engine
  component.icon = "decidim/calendar/icon.svg"
end
