# frozen_string_literal: true

require "rails"
require "decidim/core"
require "active_support/all"

module Decidim
  module Calendar
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Calendar

      routes do
        namespace :calendar do
          get "/", action: :index, as: :index
          get "/gantt", action: :gantt, as: :gantt
          get "/ical", action: :ical, as: :ical
        end
      end

      initializer "[module_name].webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer "decidim_calendar.menu" do
        Decidim.menu :menu do |menu|
          menu.add_item :calendar_menu,
                    I18n.t("menu.calendar", scope: "decidim.calendar"),
                    decidim_calendar.calendar_index_path,
                    position: 6.0,
                    active: :inclusive
        end
      end
    end
  end
end
