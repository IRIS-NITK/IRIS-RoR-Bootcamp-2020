class ApplicationController < ActionController::Base
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: 'You are not authorized. Please log in and try again.' }
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end

    session[:user_id] = nil if @current_user.nil?

    @current_user
  end
end
