class TouristSpotsController < ApplicationController
    def index
      if params[:query]
        @tourist_spots = TouristSpot.where('name LIKE ?', "%#{params[:query]}%")
      elsif params[:prefecture_name]
        @tourist_spots = TouristSpot.where('address LIKE ?', "%#{params[:prefecture_name]}%")
      else
        @tourist_spots = TouristSpot.all
      end
  
      @tourist_spots = @tourist_spots.page(params[:page]).per(12)
      @prefectures = TouristSpot.prefectures
      @total_spot_item = TotalSpotItem.new
    end
    
    def show
      @tourist_spot = TouristSpot.find(params[:id])
    end
  
     def search
      query = params[:q]
      @search_results = TouristSpot.where('name LIKE ?', "%#{query}%").pluck(:name)
      render partial: "autocomplete"
    end
  end