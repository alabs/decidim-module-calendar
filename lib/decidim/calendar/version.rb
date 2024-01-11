# frozen_string_literal: true

module Decidim
  # Holds decidim-calendar version
  module Calendar
    DECIDIM_VERSION = [">= 0.28.0", "< 0.29"].freeze

    def self.version
      "0.28.0"
    end
  end
end
