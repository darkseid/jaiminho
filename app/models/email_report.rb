class EmailReport < ActiveRecord::Base
  validates_presence_of :email_to, :template_name, :status
  enum status: [ :sending, :success, :failed ]
end
