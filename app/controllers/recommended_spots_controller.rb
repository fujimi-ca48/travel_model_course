class RecommendedSpotsController < ApplicationController
  before_action :set_spot, only: %i[show edit update destroy]
  before_action :require_login
  before_action :require_ownership, only: %i[edit update destroy]

  def index
    @q = current_user.recommended_spots.ransack(params[:q])
    @recommended_spots = @q.result(distinct: true).page(params[:page]).per(12)
    @total_spot_item = TotalSpotItem.new
  end

  def new
    @recommended_spot = current_user.recommended_spots.build
  end

  def create
    @recommended_spot = current_user.recommended_spots.build(recommended_spot_params)
    if @recommended_spot.save
      redirect_to recommended_spots_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit;end
  
  def show;end
  
  def update
    if @recommended_spot.update(recommended_spot_params)
      redirect_to recommended_spots_path, success: t('.success_update_spot')
    else
      flash.now[:danger] = t('.fail_update_spot')
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @recommended_spot.destroy!
    redirect_to recommended_spots_path, success: t('.success_delete_spot')
  end

  private
    
  def recommended_spot_params
    params.require(:recommended_spot).permit(:name, :text, :address, :img, :latitude, :longitude)
  end

  def set_spot
    @recommended_spot = current_user.recommended_spots.find(params[:id])
  end
  
  def require_ownership
    redirect_to recommended_spots_path, danger: t('not_authorized') unless @recommended_spot.user == current_user
  end
end
