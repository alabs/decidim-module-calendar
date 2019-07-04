# frozen_string_literal: true

module Decidim
  module Calendar
    class ExternalEvent < Calendar::ApplicationRecord
      include Decidim::Authorable

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      validates :title, :start_at, :end_at, presence: true
      validates :start_at, date: { before: :end_at, allow_blank: false, if: proc { |obj| obj.end_at.present? } }
      validates :end_at, date: { after: :start_at, allow_blank: true, if: proc { |obj| obj.start_at.present? } }
    end
  end
end
