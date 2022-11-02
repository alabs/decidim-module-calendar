# frozen_string_literal: true

module Decidim
  module Calendar
    module DummyCalendar
      class << self
        # This should give some compatibility with external modules (ie: term customizer)
        # this is because calendar does not use a model for the participatory space
        def where(*_args)
          Decidim::Assembly.none
        end
      end
    end
  end
end
