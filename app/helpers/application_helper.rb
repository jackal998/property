module ApplicationHelper
  def gravatar_url(email)
    gravatar_email = Digest::MD5.hexdigest(email)
    return "http://gravatar.com/avatar/#{gravatar_email}?s=32"
  end
  def show_my_name
    if current_user
      if current_user.fb_uid
        return current_user.fb_raw_data.info.name
      end
      if current_user.nickname.nil?
        return current_user.email.split("@").first 
      elsif current_user.nickname.length > 15 
        return current_user.nickname[0..14] + "..." 
      else 
        return current_user.nickname 
      end 
    else 
      return Faker::Superhero.name 
    end
  end
end
