class Admin::TouristSpotsController < Admin::BaseController
  before_action :set_spot, only: %i[show edit update destroy]
  before_action :require_login
  before_action :check_admin
  
  def index
    @tourist_spots = TouristSpot.all
  end
  
  def new
    @tourist_spot = TouristSpot.new
  end
  
  def create
    @tourist_spot = TouristSpot.new(tourist_spot_params)
  
    if @tourist_spot.save
      redirect_to admin_tourist_spots_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit;end

  def show;end
  
  def update
    if @tourist_spot.update(tourist_spot_params)
      redirect_to admin_tourist_spots_path, notice: t('.success_update_spot')
    else
      flash.now[:danger] = t('.fail_update_spot')
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @tourist_spot.destroy!
    redirect_to admin_tourist_spots_path, success: t('.success_delete_spot')
  end
  
  private
  
  def tourist_spot_params
    params.require(:tourist_spot).permit(:name, :text, :address, :spot_image)
  end

  def set_spot
    @tourist_spot = TouristSpot.find(params[:id])
  end
end
