class TouristSpotsController < ApplicationController
  def index
    @q = TouristSpot.ransack(params[:q])
    @tourist_spots = @q.result(distinct: true).page(params[:page]).per(12)
    @total_spot_item = TotalSpotItem.new
  end
    
  def show
    @tourist_spot = TouristSpot.find(params[:id])
  end
end
