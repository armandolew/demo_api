class UserResource < JSONAPI::Resource
  attributes :email, :auth_token, :active

  has_many :tasks
end
