class TaskResource < JSONAPI::Resource
  attributes :description, :status, :calculated_website_header, :user_id, :created_at, :website, :task_position

  has_one :user
  has_many :task_labels, acts_as_set: true

=begin
  before_save do
    @model.user_id = context[:user].id if @model.new_record?
  end
=end

  def status
    case @model.status
      when false then "Open"
      when true then "Done"
    end
  end

  def self.records(options={})
   options[:context][:user].tasks
  end
end