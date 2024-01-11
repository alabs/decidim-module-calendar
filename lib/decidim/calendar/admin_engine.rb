# frozen_string_literal: true

module Decidim
  module Calendar
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Calendar::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        resources :external_events
      end

      initializer "decidim_calendar.admin_menu" do
        Decidim.menu :admin_menu do |menu|
          menu.add_item :calendar,
                        I18n.t("menu.calendar", scope: "decidim.calendar"),
                        decidim_admin_calendar.external_events_path,
                        icon_name: "calendar-line",
                        position: 5.5,
                        active: :inclusive
        end
      end

      initializer "decidim_admin.register_icons" do |_app|
        Decidim.icons.register(name: "caret-bottom", icon: "caret-bottom", category: "system", description: "", engine: :core)
      end

      def load_seeds
        nil
      end
    end
  end
end
