class EmailReport < ActiveRecord::Base

  belongs_to :email_template

  validates_presence_of :email_to, :email_template, :email_template_id, :status
  enum status: [:sending, :success, :failed]

  def self.get_by_status_and_email_template_id(status: nil, email_template_id: nil)
    criteria = build_criteria(status: status, email_template_id: email_template_id)
    order(created_at: :desc).where(criteria)
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
