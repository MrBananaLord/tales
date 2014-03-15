module Authorization
  extend ActiveSupport::Concern
  include Pundit
  
  included do
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
      redirect_to new_user_session_path
    else
      redirect_to root_path, alert: "Nie masz dostępu do tej strony."
    end
  end
end
