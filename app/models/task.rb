class Task < ApplicationRecord

  # --- VALIDATIONS ----------------------------------------
  validates :description, presence: true
  validates :website, presence: true


 # --- RELATIONSHIPS -------------------------------------
  belongs_to :user

  before_create :set_calculated_website

  def set_calculated_website
    self.calculated_website_header = TaskScraper.new.get_element(self.website)
  end

end
