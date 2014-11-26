class ApiKey < ActiveRecord::Base
  before_create :generate_access_token

  private
  def generate_access_token
    self.access_token = new_unique_token
  end

  def new_unique_token
    token = SecureRandom.hex
    while ApiKey.exists?(access_token: token) do
      token = SecureRandom.hex
    end

    token
  end

end

