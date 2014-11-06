class AddExtraFieldsToEmailReport < ActiveRecord::Migration
  def change
    add_column :email_reports, :reply_to, :string
    add_column :email_reports, :cc, :string
    add_column :email_reports, :cco, :string
  end
end
