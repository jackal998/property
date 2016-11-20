module ApplicationHelper
  def gravatar_url(email)
    gravatar_email = Digest::MD5.hexdigest(email)
    return "http://gravatar.com/avatar/#{gravatar_email}?s=32"
  end
end
