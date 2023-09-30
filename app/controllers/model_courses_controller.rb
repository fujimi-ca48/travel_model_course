class ModelCoursesController < ApplicationController
  require "json"
  before_action :require_login
  before_action :set_model_course, only: %i[show edit update destroy]
  skip_before_action :require_login, only: [:show]

  def index
    q_params = params.fetch(:q, {}).permit(:prefecture_eq, :vehicle_eq)
  
    if q_params[:vehicle_eq].present?
      q_params[:vehicle_eq] = ModelCourse.vehicles[q_params[:vehicle_eq]]
    end
  
    @q = ModelCourse.ransack(q_params)
    @model_courses = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(12)
  
    @no_results = @model_courses.empty?
    @latest_model_course = current_user.model_courses.last
  end

  def new
    @model_course = ModelCourse.new
  end

  def create
    selected_total_spot_items = current_user.total_spot_items.to_a
  
    @model_course = ModelCourse.create_with_spot_items(current_user, model_course_params, selected_total_spot_items)
  
    if @model_course.persisted?
      detail_url = model_course_url(@model_course) # 新規作成したモデルコースの詳細URLを取得
      redirect_to model_courses_path(show_modal: true, detail_url: detail_url), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot_items = JSON.parse(@model_course.spot_item_data)
  end

  def edit;end

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
    @model_courses = current_user.model_courses.includes(:user).order(created_at: :desc).page(params[:page]).per(12)
  end

  def bookmarks
    @model_course = current_user.bookmark_model_courses.includes(:user).order(created_at: :desc)
  end

  def my_bookmarks
    @model_courses = current_user.bookmarks.includes(:model_course, :user).order(created_at: :desc).map(&:model_course)
    @model_courses = Kaminari.paginate_array(@model_courses).page(params[:page]).per(12)
  end

  private

  def set_model_course
    @model_course = ModelCourse.find(params[:id])
  end

  def model_course_params
    params.require(:model_course).permit(:name, :all_time, :vehicle, :prefecture)
  end
end
