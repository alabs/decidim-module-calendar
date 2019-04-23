# frozen_string_literal: true

module Decidim
  module Calendar
    class ExternalEvent < Calendar::ApplicationRecord
      include Decidim::Authorable

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      validates :title, :start_at, :end_at, presence: true

      def mounted_engine
        "decidim_calendar"
      end

      def mounted_params
        {
          host: organization.host
        }
      end
    end
  end
end
