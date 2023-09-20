class Admin::UsersController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new create], raise: false

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to admin_root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: t('.success', item: User.model_name.human)
    else
      flash.now[:danger] = t('.fail', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('.success', item: User.model_name.human)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :avatar, :avatar_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
