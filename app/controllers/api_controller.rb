class ApiController < ApplicationController
  def error( code, message = nil)
    @code = code
    @message = message
    render :error, :status => code
  end
end
