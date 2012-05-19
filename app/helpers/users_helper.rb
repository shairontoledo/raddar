module UsersHelper
  def show_protected_user_field user, field
    if(!user.send(field).blank?) && (user.id == current_user.id || (user.send("#{field}_privacy") == :public))
      label = t("user.#{field}")

      value = user.send(field.to_s)
      value = l(value) if field == :date_of_birth
      value = t("user.gender_options.#{user.gender}") if field == :gender

      if field == :facebook_url
        value = link_to('Facebook',user.facebook_url,target: '_blank')
        label = nil
      end
      
      render 'users/show_protected_field', {label: label, value: value}
    end
  end

  def facebook_link user
    unless user.facebook_url.blank?
      render 'users/show_protected_field', {label: nil, value: link_to('Facebook',user.facebook_url,target: '_blank')}
    end
  end
end
