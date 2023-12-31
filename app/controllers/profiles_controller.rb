class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :require_login

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now['danger'] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
