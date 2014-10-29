class AddSubjectToNotifierTemplates < ActiveRecord::Migration
  def change
    add_column :notification_templates, :subject, :string
  end
end
