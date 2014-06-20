class Users::AdminsController < ApplicationController
  before_filter :load_and_authorize_user

  def create
    @user.update_column :role, "admin"
    redirect_to users_path, notice: I18n.t("statements.updated")
  end
  
  def destroy
    @user.update_column :role, "standard_user"
    redirect_to users_path, notice: I18n.t("statements.updated")
  end
  
  private
  
  def load_and_authorize_user
    @user = User.find(params[:user_id])
    authorize @user, :manage_roles?
  end
end
