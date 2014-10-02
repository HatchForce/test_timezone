class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find params[:id]
  end

  def new
    @game = Game.new
    @zone = ActiveSupport::TimeZone.new(current_time_zone.name)
    @game.time_zone = @zone.name
    @game_scheduled_at = 1.hour.from_now.in_time_zone(@zone).strftime("%Y-%m-%d %I:%M %p")
  end

  def create
    selected_zone = ActiveSupport::TimeZone.new(params[:game][:time_zone])
    params[:game][:scheduled_at] = selected_zone.parse(params[:game][:scheduled_at]).utc
    @game = Game.new(params[:game])
    if @game.save!
      redirect_to game_path(@game)
    else
      @game_scheduled_at = @game.scheduled_at.strftime("%Y-%m-%d %I:%M %p")
      render :new
    end
  end

  def edit
    @game = Game.find params[:id]
    @game_scheduled_at = @game.scheduled_at_with_game_time_zone.strftime("%Y-%m-%d %I:%M %p")
  end

  def update
    @game = Game.find params[:id]
    if @game.update_attributes!(params[:game])
      redirect_to game_path(@game)
    else
      @game_scheduled_at = @game.scheduled_at_with_game_time_zone.strftime("%Y-%m-%d %I:%M %p")
      render :edit
    end
  end

  def plivo_answer
    logger.debug params
    render json: params
  end
end
