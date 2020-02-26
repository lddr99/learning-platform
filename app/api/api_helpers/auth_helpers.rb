module APIHelpers
  module AuthHelpers
    include GrapeDeviseTokenAuth::AuthHelpers
    extend Grape::API::Helpers

    def current_user
      env['warden'].user || authenticate_user
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end
end
