require 'digest/sha1'
class User < ApplicationRecord

  has_secure_password
  before_create :set_token

  # --- VALIDATIONS ----------------------------------------
  validates :email, presence: true


  # --- RELATIONSHIPS -------------------------------------
  has_many :tasks

  def set_token
    self.token = Digest::SHA1.hexdigest (self.email + self.password_digest)
  end

end
