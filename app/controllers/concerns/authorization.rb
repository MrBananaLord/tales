module Authorization
  extend ActiveSupport::Concern
  include Pundit
  
  included do
    before_filter :configure_permitted_parameters, if: :devise_controller?
    
    rescue_from Pundit::NotAuthorizedError, with: :access_denied
    helper_method :can?
  end
  
  private
  
  def can?(action, object)
    policy(object).send("#{action}?")
  end
  
  def access_denied
    if current_user.nil?
      session[:return_to] = request.fullpath
      flash[:warning] = I18n.t("statements.login_required")
      redirect_to new_user_session_path
    else
      redirect_to root_path, alert: I18n.t("statements.access_denied")
    end
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && session[:previous_url]
      session[:previous_url]
    else
      user_path(resource)
    end
  end
  
  def store_location
    unless devise_controller?
      session[:previous_url] = request.fullpath
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :remember_me)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login, :username, :email, :password, :remember_me)
    end
  end
end
