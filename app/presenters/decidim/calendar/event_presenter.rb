# frozen_string_literal: true

module Decidim
  module Calendar
    class EventPresenter < SimpleDelegator
      def color
        Decidim::Calendar.events.dig(__getobj__.class.name, :color)
      end

      def font_color
        Decidim::Calendar.events.dig(__getobj__.class.name, :fontColor)
      end

      def type
        Decidim::Calendar.events.dig(__getobj__.class.name, :id)
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

        @link ||= begin
          case __getobj__.class.name
          when "Decidim::ParticipatoryProcessStep"
            Decidim::ResourceLocatorPresenter.new(participatory_process).url
          else
            Decidim::ResourceLocatorPresenter.new(__getobj__).url
          end
        rescue NoMethodError
          ""
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

      def finish
        @finish ||= if respond_to?(:end_date)
                      end_date
                    elsif respond_to?(:end_at)
                      end_at
                    elsif respond_to?(:end_voting_date)
                      end_voting_date
                    else
                      end_time
                    end
        @finish || start
      end

      def full_title
        @full_title ||= case __getobj__.class.name
                        when "Decidim::ParticipatoryProcessStep"
                          participatory_process.title
                        else
                          title
                        end
      end

      def subtitle
        @subtitle ||= case __getobj__.class.name
                      when "Decidim::ParticipatoryProcessStep"
                        title
                      else
                        ""
                      end
      end

      def all_day?
        return false if start.nil? || finish.nil?

        (start.to_date..finish.to_date).count > 1
      end

      def hour
        return nil if start.is_a?(Date) || all_day?

        start.strftime("%H:%M")
      end
    end
  end
end
