class Task < ApplicationRecord

  # --- VALIDATIONS ----------------------------------------
  validates :description, presence: true
  validates :website, presence: true


 # --- RELATIONSHIPS -------------------------------------
  belongs_to :user

  before_create :set_calculated_website
  before_update :set_calculated_website, :if => :website_changed?

  acts_as_taggable_on :tags

  def set_calculated_website
    self.calculated_website_header = TaskScraper.new.get_element(self.website)
  end

end