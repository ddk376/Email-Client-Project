class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?
  around_filter :set_current_user
  private

  def set_current_user
    User.current_user = User.find_by(session_token: session[:token])
    yield
  ensure
    User.current_user
  end

  def sign_in!(user)
    @current_user = user
    set_current_user {}
    session[:token] = user.reset_token!
  end

  def sign_out!
    current_user.try(:reset_token!)
    User.current_user = nil
    session[:token] = nil
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by(session_token: session[:token])
    @current_user
  end

  def signed_in?
    !!current_user
  end

  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end
end
