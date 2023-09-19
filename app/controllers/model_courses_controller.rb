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
    @model_course.spot_item_data = spot_item_data.to_json

    transportation_counts = selected_total_spot_items.group_by do |item|
      TotalSpotItem.transportations.key(item.transportation)
    end.transform_values(&:count)
    most_common_transportation_key = transportation_counts.max_by { |_, count| count }&.first

    @model_course.vehicle = most_common_transportation_key if most_common_transportation_key

    address_counts = selected_total_spot_items.map do |item|
      address = item.recommended_spot&.address || item.tourist_spot&.address
      address&.match(/([北東名][都道府県]|.{2,3}[都道府県])/)&.captures&.first
    end
    address_counts.compact!
    most_common_prefecture = address_counts.max_by { |address| address_counts.count(address) }
    @model_course.prefecture = most_common_prefecture if most_common_prefecture

    if @model_course.save
      selected_total_spot_items.each(&:destroy)
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

  private

  def set_model_course
    @model_course = ModelCourse.find(params[:id])
  end

  def model_course_params
    params.require(:model_course).permit(:name, :all_time, :vehicle, :prefecture)
  end
end
