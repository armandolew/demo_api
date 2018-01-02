class Task < ApplicationRecord
  # --- VALIDATIONS ----------------------------------------
  validates :description, presence: true
  validates :website, presence: true
  validates :task_position, uniqueness: { scope: :user_id }

 # --- RELATIONSHIPS -------------------------------------
  belongs_to :user
  has_many :task_labels
  
  before_create :set_calculated_website, :position
  before_update :set_calculated_website, :if => :website_changed?

  accepts_nested_attributes_for :task_labels

  def position
    self.task_position = self.user.tasks.count < 1 ? 1 : self.user.tasks.last.task_position + 1
  end

  def move_up
    higher_task        = self.user.tasks.where("task_position < ?", self.task_position).last
    if higher_task
      current_task_position = self.task_position
      higher_task_position = higher_task.task_position

      ActiveRecord::Base.transaction do
        self.update(task_position: 0)
        higher_task.update(task_position: current_task_position)
        self.update(task_position: higher_task_position)
      end
    end
  end

  def move_down
    lower_task         = self.user.tasks.where("task_position > ?", self.task_position).first
    if lower_task
      current_task_position = self.task_position
      lower_task_position = lower_task.task_position

      ActiveRecord::Base.transaction do
        self.update(task_position: 0)
        lower_task.update(task_position: current_task_position)
        self.update(task_position: lower_task_position)
      end
    end
  end

  def place_at(new_position)
    lower_tasks        = self.user.tasks.where("task_position >= ? AND task_position < ?", new_position, self.task_position)
    if lower_tasks.length > 0
      ActiveRecord::transaction do
        self.update(task_position: 0)
        lower_tasks.map do |task|
          task.update(task_position: task.task_position + 1)
        end
      end
    end
    self.update(task_position: new_position)
  end

  private
  
    def set_calculated_website
      self.calculated_website_header = TaskScraper.new.get_element(self.website)
    end

end