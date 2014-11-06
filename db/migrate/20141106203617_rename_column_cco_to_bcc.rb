class RenameColumnCcoToBcc < ActiveRecord::Migration
  def change
    rename_column :email_reports, :cco, :bcc
  end
end
