module V1
  module Helpers
    extend Grape::API::Helpers

    def current_user
      env['warden'].user
    end

    def authenticate!
      unless current_user
        error!('401 Unauthorized', 401)
      end
    end
  end
end
