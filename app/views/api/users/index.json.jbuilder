json.array! @users do |u|
  json.partial! 'user', user: u
end

# json.array! (@users, {partial!: 'user', as: :user})
