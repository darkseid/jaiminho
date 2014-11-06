class EmailTemplate < NotificationTemplate
  validates :subject, presence: true
end
