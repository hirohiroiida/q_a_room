class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user
  helper_method :user_logined
  before_action :login_required
  before_action :if_not_admin, if: :admin_url

  private

  def user_logined
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def admin_url
    request.fullpath.include?('/admin')
  end
end
