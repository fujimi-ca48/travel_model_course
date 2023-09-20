class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :require_login

  def require_login
    return if logged_in?

    unless request.path_info == login_path
      flash.now[:danger] = t('message.require_login')
      redirect_to login_url
    end
  end
end
