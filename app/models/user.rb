require 'digest/sha1'
class User < ApplicationRecord

  has_secure_password
  before_create :set_token, :set_confirmation_token

  # --- VALIDATIONS ----------------------------------------
  validates :email, presence: true
  validates_uniqueness_of :email


  # --- RELATIONSHIPS -------------------------------------
  has_many :tasks

  private

    def set_token
      self.token = Digest::SHA1.hexdigest (self.email + self.password_digest)
    end

    def set_confirmation_token
  	  self.confirmation_token = Digest::SHA1.hexdigest (self.email + Time.zone.now.to_s)
    end

end