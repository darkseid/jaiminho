class EmailTemplate < NotificationTemplate
  validates :subject, presence: true

  # has_many :email_reports

  %w(subject body).each do |action|
    # 'data' argument is used by 'binding' on background. Do not delete it.
    define_method("render_#{action}") do |data|
      ERB.new(send(action)).result(binding).chomp
    end
  end
end
