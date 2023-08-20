class RecommendedSpotsController < ApplicationController
    before_action :set_spot, only: %i[show edit update destroy]
    
    def index
      @q = RecommendedSpot.ransack(params[:q])
      @recommended_spots = @q.result(distinct: true).page(params[:page]).per(5)
      @total_spot_item = TotalSpotItem.new 
    end
    
    def new;end
    
    def create
      @recommended_spot = current_user.recommended_spots.build(recommended_spot_params)
      if @recommended_spot.save
        redirect_to new_recommended_spot_path, success: t('success')
      else
        flash.now[:danger] = t('fail')
        render :new, status: :unprocessable_entity
      end
    end
    
    def edit;end
  
    def show;end
    
    def update
      if @recommended_spot.update(recommended_spot_params)
        @recommended_spot.user = current_user
        redirect_to recommended_spots_path, t('success_update_spot')
      else
        flash.now[:danger] = t('fail_update_spot')
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @recommended_spot.destroy!
      redirect_to recommended_spots_path, success: t('success_delete_spot')
    end

    private
    
    def recommended_spot_params
      params.require(:recommended_spot).permit(:name, :text, :address, :spot_image, :latitude, :longitude)
    end
  
    def find_spot
      @recommended_spot = current_user.recommended_spots.find(params[:id])
    end
  end
