class Admin::DashboardsController < Admin::BaseController
  before_action :require_login
  before_action :check_admin

  def index;end
end
