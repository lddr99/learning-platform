module V1
  module User
    class API < Grape::API
      helpers APIHelpers::AuthHelpers

      params do
        requires :id, type: Integer, desc: 'User ID.'
      end

      route_param :id do
        mount Courses
      end
    end
  end
end
