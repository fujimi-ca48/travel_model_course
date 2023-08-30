class TouristSpotsController < ApplicationController
  def index
    @q = params[:query]
    if @q
      @tourist_spots = TouristSpot.where('name LIKE ?', "%#{@q}%").page(params[:page]).per(12)
    else
      @tourist_spots = TouristSpot.page(params[:page]).per(12)
    end
    @total_spot_item = TotalSpotItem.new
  end

    
  def show
    @tourist_spot = TouristSpot.find(params[:id])
  end
end
