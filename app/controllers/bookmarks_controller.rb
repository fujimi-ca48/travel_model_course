class BookmarksController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @model_course.bookmarks.create(user: current_user)
    respond_to(&:turbo_stream)
  end

  def destroy
    @bookmark= @model_course.bookmarks.find_by(user: current_user)
    @bookmark.destroy
    respond_to(&:turbo_stream)
  end

  private

  def set_post
    @model_course= ModelCourse.find(params[:model_course_id])
  end
end