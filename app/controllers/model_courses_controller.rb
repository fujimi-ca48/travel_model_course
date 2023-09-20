class ModelCoursesController < ApplicationController
  require 'json'
  before_action :require_login
  before_action :set_model_course, only: %i[show edit update destroy]

  def index
    q_params = params.fetch(:q, {}).permit(:prefecture_eq, :vehicle_eq)

    q_params[:vehicle_eq] = ModelCourse.vehicles[q_params[:vehicle_eq]] if q_params[:vehicle_eq].present?

    @q = ModelCourse.ransack(q_params)
    @model_courses = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)

    @no_results = @model_courses.empty?
  end

  def new
    @model_course = ModelCourse.new
  end

  def create
    total_spot_items = current_user.total_spot_items.to_a

    @model_course = ModelCourse.create_with_data_and_save(current_user, model_course_params, total_spot_items)
  
    if @model_course.persisted?
      redirect_to model_courses_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot_items = JSON.parse(@model_course.spot_item_data)
  end

  def edit; end

  def update
    if @model_course.update(model_course_params)
      redirect_to model_courses_path, success: t('.success_update_model_course')
    else
      flash.now[:danger] = t('.fail_update_model_course')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @model_course.destroy!
    redirect_to model_courses_path, success: t('.success_delete_model_course')
  end

  def my_model_courses
    @model_courses = current_user.model_courses.order(created_at: :desc).page(params[:page]).per(12)
  end

  private

  def set_model_course
    @model_course = ModelCourse.find(params[:id])
  end

  def model_course_params
    params.require(:model_course).permit(:name, :all_time, :vehicle, :prefecture)
  end
end
