#require 'devise_user_metering/hooks/user_metering'
#
module Devise
  module Models
    module UserMetering
      # This function returns a decimal between 0 and 1 that reflects the amount of the month this user has been 'active'
      def active_proportion_of_month(time)
        active_proportion(time, time.beginning_of_month, time.end_of_month)
      end
      
      def active_proportion_of_interval(time, time_start, time_end)
        active_proportion(time, time_start, time_end)
      end

      def activate!
        self.activated_at = Time.new
        self.active = true
        self.save!
      end

      def deactivate!
        now = Time.new
        self.deactivated_at = now
        self.active = false
        self.rollover_active_duration += now - [self.activated_at, now.beginning_of_month].max
        self.save!
      end

      def billed!
        self.rollover_active_duration = 0
        self.save!
      end
      
      private
      
      def active_proportion(time, month, end_month)
        if end_month > Time.now
          raise StandardError.new("You can't get meter data for incomplete months")
        end
        if month < self.activated_at.beginning_of_month
          raise StandardError.new("No usage data retained for that month")
        end

        in_month = ->(time) { (month..end_month).cover?(time) }
        if in_month.call(self.activated_at) || in_month.call(self.deactivated_at)
          if !active && self.deactivated_at < month
            return 0
          end
          month_duration = end_month - month
          remainder = self.active ? [end_month - self.activated_at, 0].max : 0
          (remainder + self.rollover_active_duration) / month_duration
        else
          self.active ? 1 : 0
        end        
      end
      
    end
  end
end

