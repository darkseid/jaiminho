class EmailReport < ActiveRecord::Base

  belongs_to :email_template

  validates_presence_of :email_to, :email_template, :email_template_id, :status
  enum status: [:sending, :success, :failed]

  def mark_as_successful
    @status = :success
    save
  end
end
