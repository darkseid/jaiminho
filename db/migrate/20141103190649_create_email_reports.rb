class CreateEmailReports < ActiveRecord::Migration
  def change
    create_table :email_reports do |t|
      t.string :email_to
      t.string :template_name
      t.text :data
      t.string :status

      t.timestamps
    end
  end
end
