# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Calendar
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Calendar

      routes do
      end

      initializer "decidim_calendar.assets" do |app|
        app.config.assets.precompile += %w(decidim_calendar_manifest.js decidim_calendar_manifest.css)
      end
    end
  end
end
