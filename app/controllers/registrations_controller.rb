class RegistrationsController < Devise::RegistrationsController


  def change_password
    @user= current_user
  end

  private

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end
