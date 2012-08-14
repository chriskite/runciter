module Api
  class ApplicationController < ActionController::Base
    respond_to :json
    #rescue_from StandardError, with: :handle_exception
    #rescue_from Exception, with: :handle_exception
  end
end
