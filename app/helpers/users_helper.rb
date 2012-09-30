module UsersHelper
  def show_protected_user_field user, field
    if(!user.send(field).blank?) && (user.id == current_user.id || (user.send("#{field}_privacy") == :public))
      label = t("user.#{field}")

      value = user.send(field.to_s)
      value = l(value) if field == :date_of_birth
      value = t("user.gender_options.#{user.gender}") if field == :gender
      
      render 'users/show_protected_field', {label: label, value: value}
    end
  end

  def account_link account
    render 'users/show_protected_field', {label: nil, value: link_to(account.provider.to_s.titleize, account.url, target: '_blank')}
  end

  def last_users
    User.where(:confirmed_at.exists => true).order_by([:confirmed_at, :desc])
  end
end
