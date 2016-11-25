module ApplicationHelper
  def gravatar_url(email)
    gravatar_email = Digest::MD5.hexdigest(email)
    return "http://gravatar.com/avatar/#{gravatar_email}?s=32"
  end
  def user_name(user)
    if current_user
      if user.fb_uid
        return user.fb_name #add_row
      end
      if user.nickname
        if user.nickname.length > 15 
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
end
