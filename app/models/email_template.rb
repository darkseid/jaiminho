class EmailTemplate < NotificationTemplate
  validates :subject, presence: true
  has_many :email_reports

  def self.availables
    EmailTemplate.all
  end
end
