class LikesController < ApplicationController
  before_action :set_model_course, only: %i[create destroy]

  def create
    @model_course.likes.create(user: current_user)
    respond_to(&:turbo_stream)
  end

  def destroy
    @like = @model_course.likes.find_by(user: current_user)
    @like.destroy
    respond_to(&:turbo_stream)
  end

  private

  def set_model_course
    @model_course= ModelCourse.find(params[:model_course_id])
  end
end
