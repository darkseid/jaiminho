class NotificationTemplate < ActiveRecord::Base
  validates :name, uniqueness: true, presence: :true
  validates :body, presence: :true
end
