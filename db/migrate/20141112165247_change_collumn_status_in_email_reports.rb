class ChangeCollumnStatusInEmailReports < ActiveRecord::Migration
  def change
    change_column :email_reports, :status, :integer, \
                  null: false, default: 0
  end
end
