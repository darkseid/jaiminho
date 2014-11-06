class EmailReport < ActiveRecord::Base
  validates_presence_of :email_to, :template_name, :status
  enum status: [ :sending, :success, :failed ]
  after_initialize :default_values

  def default_values
    self.status ||= :sending
  end
end
