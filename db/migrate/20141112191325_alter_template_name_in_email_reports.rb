class AlterTemplateNameInEmailReports < ActiveRecord::Migration
  def change
    remove_column :email_reports, :template_name
    add_column :email_reports, :email_template_id, :integer, null: false
  end
end
