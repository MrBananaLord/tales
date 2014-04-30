class Users::ConfirmationsController < Devise::ConfirmationsController
  layout "authorization"
  
  # Akcja nadpisana, żeby automatycznie logować użytkownika
  # po potwierdzeniu konta. Domyslnie nowy devise tego nie robi.
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      sign_in(resource_name, resource)
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end
  
  protected
  
  def after_confirmation_path_for(resource_name, resource)
    user_path(resource)
  end
end
