class RecommendedSpotsController < ApplicationController
    before_action :set_spot, only: %i[show edit update destroy]
    
    def index
      @q = RecommendedSpot.ransack(params[:q])
      @recommended_spots = @q.result(distinct: true).page(params[:page]).per(5)
    end
    
    def new;end
    
    def create
      @recommended_spot = current_user.recommended_spots.build(recommended_spot_params)
      if @recommended_spot.save
        redirect_to new_recommended_spot_path, success: '登録しました'
      else
        flash.now[:danger] = '登録できませんでした'
        render :new, status: :unprocessable_entity
      end
    end
    
    def edit;end
  
    def show;end
    
    def update
      if @recommended_spot.update(recommended_spot_params)
        @recommended_spot.user = current_user
        redirect_to recommended_spots_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @recommended_spot.destroy!
      redirect_to recommended_spots_path, success: '削除しました'
    end
      
        def add_to_model_course
          recommended_spot = RecommendedSpot.find(params[:recommended_spot_id])
          session[:selected_recommended_spots] ||= []
      
          unless session[:selected_recommended_spots].include?(recommended_spot.id)
            session[:selected_recommended_spots] << recommended_spot.id
            flash[:success] = "#{recommended_spot.name} をおすすめスポットに追加しました。"
          else
            flash[:danger] = "#{recommended_spot.name} はすでに選ばれています。"
          end
      
          redirect_to recommended_spots_path
        end
    

    private
    
    def recommended_spot_params
      params.require(:recommended_spot).permit(:name, :text, :address, :spot_image, :latitude, :longitude)
    end
  
    def find_spot
      @recommended_spot = current_user.recommended_spots.find(params[:id])
    end
  end
