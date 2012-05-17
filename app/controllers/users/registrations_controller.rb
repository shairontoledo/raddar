class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    if @user.update_without_password(params[:user])
      set_flash_message :notice, :updated
      #sign_in @user, :bypass => true
      respond_with @user, :location => after_update_path_for(@user)
    else
      clean_up_passwords @user
      respond_with @user
    end
  end

end