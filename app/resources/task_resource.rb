class TaskResource < JSONAPI::Resource
  attributes :description, :status, :calculated_website_header, :created_at, :website,  :tags

  def tags
  	@model.tag_list
  end

  def self.records(options={})
   options[:context][:api_user].tasks
  end

end
