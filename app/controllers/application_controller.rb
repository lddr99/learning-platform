class ApplicationController < ActionController::Base
  # @notice disable CSRF the check
  skip_before_action :verify_authenticity_token

  include DeviseTokenAuth::Concerns::SetUserByToken
end
