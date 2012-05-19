class Users::PasswordsController < Devise::RegistrationsController
  before_filter :authenticate_user!, only: [:change, :do_change]

  def change
    @user = User.find(current_user.id)
  end


  def do_change
    @user = User.find(current_user.id)

    if @user.update_with_password(params[:user])
      flash[:notice] = t('flash.password.changed')
      sign_in @user, :bypass => true
      respond_with @user, location: root_path
    else
      clean_up_passwords @user
      render 'change'
    end
  end
end