class CalendarController < ApplicationController
    def week
        @courses = Course.where(
          start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
        )
      end
    
    def month
      @courses = Course.where(
        start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
      )
    end
end
