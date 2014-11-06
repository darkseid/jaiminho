class DropNotificationTemplatesTable < ActiveRecord::Migration
  def change
    drop_table :notification_templates
  end
end
