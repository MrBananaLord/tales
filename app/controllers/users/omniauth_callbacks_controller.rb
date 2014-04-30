class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout "authorization"
  
  def facebook
    service = User::SignInFromFacebookService.new(request.env["omniauth.auth"])
    @user = service.user

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # throw if !@user.activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    elsif @user.errors[:email].any?
      set_flash_message(:alert, :failure, kind: "Facebook",
                        reason: I18n.t(".email_not_verified"))
      redirect_to new_user_session_path
    else
      redirect_to @user
    end
  end
end
