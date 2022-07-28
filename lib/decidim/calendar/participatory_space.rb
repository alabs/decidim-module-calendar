# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_participatory_space(:calendar) do |participatory_space|
  participatory_space.icon = "media/images/decidim_calendar_icon.svg"
  participatory_space.model_class_name = "Decidim::Calendar::DummyCalendar"

  participatory_space.context(:public) do |context|
    context.engine = Decidim::Calendar::Engine
  end

  # Return a empty relation from another space to prevent unexpected crashes when used
  participatory_space.participatory_spaces do |_organization|
    Decidim::Assembly.none
  end

  participatory_space.context(:admin) do |context|
    context.engine = Decidim::Calendar::AdminEngine
  end
end
