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

  def accounts_links user
    html = ''

    user.accounts.each do |account|
      if user.id == current_user.id || account.privacy == :public
        html = html + link_to(image_tag("omniauth/#{account.provider}/logo.png", alt: account.provider.to_s.titleize, :class => 'size40'), account.url, target: '_blank', :class => 'user_account_link')
      end
    end

    raw html
  end

  def last_users
    User.where(:confirmed_at.exists => true).order_by([:confirmed_at, :desc])
  end
end
