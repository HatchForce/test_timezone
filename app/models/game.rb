class Game < ActiveRecord::Base
  attr_accessible :name, :time_zone, :scheduled_at

  validates_presence_of :name, :time_zone, :scheduled_at

  def game_time_zone
    zone = ActiveSupport::TimeZone.new(self.time_zone)
  end

  def scheduled_at_with_zone(zone)
    self.scheduled_at.in_time_zone(zone)
  end

  def scheduled_at_with_game_time_zone
    self.scheduled_at.in_time_zone(self.game_time_zone)
  end

  def scheduled_at_with_user_time_zone(user_time_zone)
    self.scheduled_at.in_time_zone(user_time_zone)
  end
end
