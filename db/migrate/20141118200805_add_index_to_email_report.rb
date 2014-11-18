class AddIndexToEmailReport < ActiveRecord::Migration
  def change
    add_index(
      :email_reports,
      [:status, :email_template_id, :created_at],
      name: "idx_st_email_t_created"
    )
  end
end
