class AlterTemplateNameInEmailReports < ActiveRecord::Migration
  def change
    rename_column :email_reports, :template_name, :email_template_id
    change_column :email_reports, :email_template_id, :integer, null: false
  end
end
