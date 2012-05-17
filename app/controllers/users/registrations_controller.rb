class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    if @user.update_without_password(params[:user])
      if @user.respond_to?(:pending_reconfirmation?) && @user.pending_reconfirmation?
        flash_key = :update_needs_confirmation
      end
      set_flash_message :notice, flash_key || :updated
    else
      clean_up_passwords @user
    end
    respond_with @user
  end

end