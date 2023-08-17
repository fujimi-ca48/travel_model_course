class Admin::UsersController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create]

  def new
    @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to admin_root_path, success: 'ユーザー登録に成功しました'
    else
      flash.now[:danger] = 'ユーザー登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end
    
   private
    
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
