class AddCalculatedWebsiteHeaderToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :calculated_website_header, :string
  end
end
