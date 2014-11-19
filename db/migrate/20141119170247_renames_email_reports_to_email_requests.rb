class RenamesEmailReportsToEmailRequests < ActiveRecord::Migration
  def up
    remove_index :email_reports, name: "idx_st_email_t_created"
    rename_table :email_reports, :email_requests
    add_index(
      :email_requests,
      [:status, :email_template_id, :created_at],
      name: "idx_st_email_t_created"
    )
  end

  def down
    remove_index :email_requests, name: "idx_st_email_t_created"
    rename_table :email_requests, :email_reports
    add_index(
      :email_reports,
      [:status, :email_template_id, :created_at],
      name: "idx_st_email_t_created"
    )
  end
end
