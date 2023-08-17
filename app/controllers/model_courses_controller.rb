class ModelCoursesController < ApplicationController
  def new
    @model_course = ModelCourse.new
    @selected_spots = session[:selected_tourist_spots].map { |spot_id| TouristSpot.find(spot_id) }
    @selected_recommended_spots = session[:selected_recommended_spots]&.map { |id| RecommendedSpot.find(id) }
  end

  def create
    @model_course = ModelCourse.new(model_course_params)
    if @model_course.save
      flash[:success] = 'モデルコースを作成しました。'
      redirect_to model_course_path(@model_course)
    else
      flash.now[:danger] = 'モデルコースの作成に失敗しました。'
      render :new
    end
  end

  def sort
    model_course = ModelCourse.find(params[:model_course_id])
    model_course.update(model_course_params)
    render body: nil
  end

  private

  def model_course_params
    params.require(:model_course).permit(:name, :all_time, :row_order_position, recommended_spots_attributes: [:id, :name, :address, :text, :latitude, :longitude, :img, :_destroy])
  end
end