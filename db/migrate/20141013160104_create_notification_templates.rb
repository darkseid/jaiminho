class CreateNotificationTemplates < ActiveRecord::Migration
  def change
    create_table :notification_templates do |t|
      t.string :name
      t.text :body
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
