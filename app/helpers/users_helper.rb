module UsersHelper
  def show_protected_user_field user, field
    if(user.id == current_user.id || (user.send("#{field}_visibility") == :public))
      label = t("user.#{field}")
      value = user.send(field.to_s)
      value = l(value) if field == :date_of_birth
      value = t("simple_form.options.user.gender.#{user.gender}") if field == :gender
      render 'users/show_protected_field', {label: label, value: value}
    end
  end

  def facebook_link user
    unless user.facebook_url.blank?
      render 'users/show_protected_field', {label: nil, value: link_to('Facebook',user.facebook_url,target: '_blank')}
    end
  end
end
