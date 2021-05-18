json.array! @authors do |author|
  json.extract! author, :id, :username, :email, :authentication_token
end