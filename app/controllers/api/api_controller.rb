module Api
  class ApiController < ApplicationController

    respond_to :json

    def error( code, message = nil)
      @code = code
      @message = message
      render :error, :status => code
    end

  end
end
