class EmailTemplate < NotificationTemplate
  validates :subject, presence: true

  %w(subject body).each do |action|
    define_method("render_#{action}") do |data|
      ERB.new(send(action)).result(binding).chomp
    end
  end
end
