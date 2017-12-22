class UserResource < JSONAPI::Resource
  attributes :email, :token, :active
end
