module Api
  class ApiController < ApplicationController
    before_action :check_access
    respond_to :json

    private

    def check_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end

  end
end
