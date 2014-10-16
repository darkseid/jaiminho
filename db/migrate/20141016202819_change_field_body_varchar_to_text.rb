class ChangeFieldBodyVarcharToText < ActiveRecord::Migration
  def change
    change_column :notification_templates, :body, :text
  end
end
