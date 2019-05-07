# frozen_string_literal: true

module Decidim
  module Calendar
    class EventPresenter < SimpleDelegator
      def color
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "#238ff7"
        when "Decidim::Meetings::Meeting"
          "#fabc6c"
        when "Decidim::Calendar::ExternalEvent"
          "#5fbd4c"
        when "Decidim::Debates::Debate"
          "#d87537"
        when "Decidim::Consultation"
          "#A854BD"
        end
      end

      def type
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "participatory_step"
        when "Decidim::Meetings::Meeting"
          "meeting"
        when "Decidim::Calendar::ExternalEvent"
          "external_event"
        when "Decidim::Debates::Debate"
          "debate"
        when "Decidim::Consultation"
          "consultation"
        end
      end

      def full_id
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "#{participatory_process.id}-#{id}"
        else
          id
        end
      end

      def parent
        case __getobj__.class.name
        when "Decidim::ParticipatoryProcessStep"
          "#{participatory_process.id}-#{participatory_process.steps.find_by(position: position - 1).id}" if position.positive?
        end
      end

      def link
        return url if respond_to?(:url)

        @link ||= case __getobj__.class.name
                  when "Decidim::ParticipatoryProcessStep"
                    Decidim::ResourceLocatorPresenter.new(participatory_process).url
                  else
                    Decidim::ResourceLocatorPresenter.new(__getobj__).url
                  end
      end

      def start
        # byebug
        @start ||= if respond_to?(:start_date)
                     start_date
                   elsif respond_to?(:start_at)
                     start_at
                   elsif respond_to?(:start_voting_date)
                     start_voting_date
                   else
                     start_time
                   end
      end

      def end
        @end ||= if respond_to?(:end_date)
                   end_date
                 elsif respond_to?(:end_at)
                   end_at
                 elsif respond_to?(:end_voting_date)
                   end_voting_date
                 else
                   end_time
                 end
      end

      def full_title
        @full_title ||= case __getobj__.class.name
                        when "Decidim::ParticipatoryProcessStep"
                          participatory_process.title.merge(title) do |_k, v, o|
                            "#{v} - #{o}"
                          end
                        else
                          title
                        end
      end
    end
  end
end
