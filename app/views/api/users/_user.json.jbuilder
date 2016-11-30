# json.ignore_nil!


#通常不會使用動態的key，因為api裡面使用到的key原則上都會是固定的值。
json.set! user.id, user.id

json.user_id user.id
json.user_email user.email
json.user_nickname user.nickname

json.(user, :id, :nickname)