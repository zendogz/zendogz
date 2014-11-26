class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :admin?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def current_user
      @current_user ||= Person.find(session[:user_id]) if session[:user_id]
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to request.headers["Referer"] || root_path
    end

    def admin?
      current_user && current_user.admin?
    end
end