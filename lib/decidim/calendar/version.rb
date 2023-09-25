# frozen_string_literal: true

module Decidim
  # Holds decidim-calendar version
  module Calendar
    DECIDIM_VERSION = [">= 0.27.0", "< 0.28"].freeze

    def self.version
      "0.27.0"
    end
  end
end
