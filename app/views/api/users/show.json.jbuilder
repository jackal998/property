# ruby code
json.Hi do
  json.partial! 'user', user: @user
end

json.path user_path(@user)