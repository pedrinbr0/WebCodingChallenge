class SchedulesController < ApplicationController
  require 'json'

  def create
    if params[:file].present?
      file = params[:file].tempfile
      talks = file.readlines.map(&:chomp)

      scheduler = ConferenceScheduler.new(talks)
      schedule = scheduler.schedule

      render json: { schedule: schedule }, status: :ok
    else
      render json: { error: "Nenhum arquivo enviado" }, status: :unprocessable_entity
    end
  end
end
