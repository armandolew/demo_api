class Task < ApplicationRecord

  # --- VALIDATIONS ----------------------------------------
  validates :description, presence: true
  validates :website, presence: true


 # --- RELATIONSHIPS -------------------------------------
  belongs_to :user

end
