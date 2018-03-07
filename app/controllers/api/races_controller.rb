module Api
  class RacesController < ApplicationController
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        # @race = Race.find(params[:id])
        # render :race
      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        # render plain: :nothing, status: :ok
        render plain: params[:race][:name]
      # else
      #   @race = Race.new(race_params)
      #
      #   if @race.save
      #     render plain: race_params[:name], status: :created
      #   else
      #     render json: @race.errors
      #   end
      end
    end
  end
end