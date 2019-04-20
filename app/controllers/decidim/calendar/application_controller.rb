# frozen_string_literal: true

module Decidim
  module Calendar
    class ApplicationController < Decidim::ApplicationController
      include NeedsPermission

      private

      def permission_class_chain
        [
          Decidim::Permissions
        ]
      end

      def permission_scope
        :public
      end
    end
  end
end
