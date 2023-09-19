class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :require_login

  def require_login
    return if logged_in?

    redirect_to login_url, danger: t('message.require_login')
  end
end
