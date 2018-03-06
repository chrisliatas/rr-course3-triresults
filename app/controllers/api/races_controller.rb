module Api
  class RacesController < ApplicationController
    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
      end
    end
  end
end