# frozen_string_literal: true

module Decidim
  module Calendar
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Calendar::Admin
      
      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
      end

      def load_seeds
        nil
      end
    end
  end
end
