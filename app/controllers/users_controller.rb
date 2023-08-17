class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to tourist_spots_path, success: '管理者ユーザーを作成できませんでした'
    else
      flash.now[:danger] = '管理者ユーザーを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
