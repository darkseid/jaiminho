class RemoveFieldsFromAndToNotifiationCenter < ActiveRecord::Migration
  def change
    remove_column :notification_templates, :from
    remove_column :notification_templates, :to
  end
end
