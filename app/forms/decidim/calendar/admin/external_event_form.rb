# frozen_string_literal: true

module Decidim
  module Calendar
    module Admin
      class ExternalEventForm < Decidim::Form
        include TranslatableAttributes

        translatable_attribute :title, String
        attribute :start_at, Decidim::Attributes::TimeWithZone
        attribute :end_at, Decidim::Attributes::TimeWithZone
        attribute :url, String

        validates :title, translatable_presence: true
        validates :title, :start_at, :end_at, :url, presence: true
        validates :start_at, date: { before: :end_at, allow_blank: false, if: proc { |obj| obj.end_at.present? } }
        validates :end_at, date: { after: :start_at, allow_blank: true, if: proc { |obj| obj.start_at.present? } }
      end
    end
  end
end
