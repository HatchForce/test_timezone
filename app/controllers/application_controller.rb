class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_time_zone

  helper_method :current_time_zone, :time_now_user_zone

  def current_time_zone
    @current_time_zone
  end

  def time_now_user_zone
    time = Time.now.in_time_zone(current_time_zone)
  end


  def set_time_zone
    @current_time_zone = ActiveSupport::TimeZone.new(cookies[:time_zone] || "UTC")
  end
end
