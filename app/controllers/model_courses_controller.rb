class ModelCoursesController < ApplicationController
  require "json"
  before_action :require_login

  def index
    @q = ModelCourse.ransack(params[:q])
    @model_courses = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def new
    @model_course = ModelCourse.new
  end

  def create
    selected_total_spot_items = current_user.total_spot_items.to_a
    spot_item_data = selected_total_spot_items.map do |item|
      {
        recommended_spot_id: item.recommended_spot_id,
        tourist_spot_id: item.tourist_spot_id,
        duration: item.duration,
        transportation: item.transportation,
        position: item.position
      }
    end
  
    @model_course = current_user.model_courses.build(model_course_params)
    @model_course.spot_item_data = spot_item_data.to_json  # JSON形式に変換して保存
  
    if @model_course.save
      selected_total_spot_items.each(&:destroy)
      redirect_to model_courses_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @model_course = ModelCourse.find(params[:id])
    @spot_items = JSON.parse(@model_course.spot_item_data)
  end

  private

  def model_course_params
    params.require(:model_course).permit(:name, :all_time)
  end
end
