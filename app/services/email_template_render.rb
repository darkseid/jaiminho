class EmailTemplateRender
  attr_reader :subject, :body

  def initialize(email_template, data)
    @data = data
    @subject = render(email_template.subject)
    @body = render(email_template.body)
  end

  private

  def render(text)
    data = HashWithIndifferentAccess.new(@data)
    ERB.new(text).result(binding).chomp
  end
end
