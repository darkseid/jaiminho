class EmailRequest < ActiveRecord::Base

  belongs_to :email_template
  validates_associated :email_template
  validates_presence_of :email_to, :email_template_id, :status
  enum status: [:sending, :success, :failed]

  delegate :name, to: :email_template, prefix: :template

  def self.get_by_status_and_email_template_id(status: nil, email_template_id: nil)
    criteria = build_criteria(status: status, email_template_id: email_template_id)
    order(created_at: :desc).where(criteria)
  end

  def self.available_status
    statuses.to_a
  end

  def mark_as_successful
    @status = :success
    save
  end

  private
  def self.build_criteria(criterions={})
    criterions.reject{|field, value| value.nil?}
  end
end
