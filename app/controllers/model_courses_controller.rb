class ModelCoursesController < ApplicationController
  require "json"
  before_action :require_login

  def index
    q_params = params.fetch(:q, {}).permit(:prefecture_eq, :vehicle_eq)
  
    if q_params[:vehicle_eq].present?
      q_params[:vehicle_eq] = ModelCourse.vehicles[q_params[:vehicle_eq]]
    end
  
    @q = ModelCourse.ransack(q_params)
    @model_courses = @q.result(distinct: true).page(params[:page]).per(12)
  
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


    transportation_counts = selected_total_spot_items.group_by { |item| TotalSpotItem.transportations.key(item.transportation) }.transform_values(&:count)
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
    @model_course = ModelCourse.find(params[:id])
    @spot_items = JSON.parse(@model_course.spot_item_data)
  end

  private

  def model_course_params
    params.require(:model_course).permit(:name, :all_time, :vehicle, :prefecture)
  end
end
