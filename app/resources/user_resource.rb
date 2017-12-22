class UserResource < JSONAPI::Resource
  attributes :email, :auth_token, :active
end
