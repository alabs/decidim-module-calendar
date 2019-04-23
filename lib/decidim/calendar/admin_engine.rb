# frozen_string_literal: true

module Decidim
  module Calendar
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Calendar::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
      end

      initializer "decidim_calendar.admin_menu" do
        Decidim.menu :admin_menu do |menu|
          menu.item I18n.t("menu.calendar", scope: "decidim.calendar"),
                    "#",
                    icon_name: "calendar",
                    position: 5.5,
                    active: :inclusive
        end
      end

      def load_seeds
        nil
      end
    end
  end
end
