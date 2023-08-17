class SelectedTouristSpotsController < ApplicationController
   def index
    @selected_tourist_spots = session[:selected_tourist_spots_data] || []
   end
    
  def create
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    session[:selected_tourist_spots] ||= []

    unless session[:selected_tourist_spots].include?(tourist_spot.id)
      session[:selected_tourist_spots] << tourist_spot.id
      flash[:success] = "#{tourist_spot.name} を選んだ観光地に追加しました。"
    else
      flash[:danger] = "#{tourist_spot.name} はすでに選ばれています。"
    end

    redirect_to tourist_spots_path
  end

  def destroy
    tourist_spot_id = params[:id].to_i
    tourist_spot = TouristSpot.find(tourist_spot_id)
    session[:selected_tourist_spots].delete(tourist_spot_id)
    redirect_to selected_tourist_spots_path, success: "#{tourist_spot.name} を選んだ観光地から削除しました。"
  end
end
