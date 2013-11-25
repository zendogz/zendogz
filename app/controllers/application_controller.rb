class ApplicationController < ActionController::Base
  before_filter :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  delegate :can?, to: :current_permission
  helper_method :current_user, :can?

  private

    def current_user
      @current_user ||= Person.find(session[:user_id]) if session[:user_id]
    end

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def authorize
      if !current_permission.can?(params[:controller], params[:action])
        redirect_to root_url, alert: "Not authorized."
      end
    end
end