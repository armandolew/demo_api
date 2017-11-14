class User < ApplicationRecord

  # --- VALIDATIONS ----------------------------------------
  validates :email, presence: true


  # --- RELATIONSHIPS -------------------------------------
  has_many :tasks



  def create_auth_token
  end

end
