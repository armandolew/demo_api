class Task < ApplicationRecord

  # --- VALIDATIONS ----------------------------------------
  validates :description, presence: true
  validates :website, presence: true
  #validates_uniqueness_of :task_position, scope: self.user
  validates :task_position, uniqueness: { scope: :user_id }


 # --- RELATIONSHIPS -------------------------------------
  belongs_to :user

  before_create :set_calculated_website, :position
  before_update :set_calculated_website, :if => :website_changed?

  acts_as_taggable_on :tags

  def position
    self.task_position = self.user.tasks.count < 1 ? 1 : self.user.tasks.last.task_position + 1
  end

  def move_up
    higher_task        = self.user.tasks.where("task_position < ?", self.task_position).last
    if higher_task
      current_task_position = self.task_position
      higher_task_position = higher_task.task_position
      self.update(task_position: 0)
      higher_task.update(task_position: current_task_position)
      self.update(task_position: higher_task_position)
    end
  end

  def move_down
    lower_task         = self.user.tasks.where("task_position > ?", self.task_position).last
    if lower_task
      current_task_position = self.task_position
      lower_task_position = lower_task.task_position
      self.update(task_position: 0)
      lower_task.update(task_position: current_task_position)
      self.update(task_position: lower_task_position)
    end
  end

  def place_at(new_position)
    lower_tasks        = self.user.tasks.where("task_position >= ? AND task_position < ?", new_position, self.task_position)
    
    self.update(task_position: 0)

    if lower_tasks.count > 0
      lower_tasks.map do |task|
        task.update(task_position: task.task_position + 1)
      end
    end

    self.update(task_position: new_position)
  end

  private
  
    def set_calculated_website
      self.calculated_website_header = TaskScraper.new.get_element(self.website)
    end

end