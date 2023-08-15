class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create]
  skip_before_action :require_login, only: %i[new create], raise: false

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, status: :see_other, success: t('.success')
  end
end
