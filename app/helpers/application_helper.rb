module ApplicationHelper

  def user_name(user)
    if current_user
      if user.fb_uid
        return user.fb_name
      end
      if user.nickname
        if user.nickname.length > 14 
          return user.nickname[0..14] + "..."
        else
          return user.nickname
        end
      else
        return user.email.split("@").first
      end
    else
      return Faker::Superhero.name
    end
  end

  def avatar_url
    if current_user
      if current_user.fb_uid
        return current_user.fb_avatar
      else
        return gravatar_url(current_user.email.strip.downcase)
      end
    else
      return gravatar_url("#{user_name(current_user).strip.downcase}@gmail.com")
    end
  end

  def gravatar_url(email)
    gravatar_email = Digest::MD5.hexdigest(email)
    return "http://gravatar.com/avatar/#{gravatar_email}?s=32"
  end
end
