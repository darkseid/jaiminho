class NotificationTemplate < ActiveRecord::Base
  self.abstract_class = true
  validates :name, uniqueness: true, presence: true
  validates :body, presence: true
end
