class EmailReport < ActiveRecord::Base
  validates_presence_of :email_to, :template_name, :status
end
