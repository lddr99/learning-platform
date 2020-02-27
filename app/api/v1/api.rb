module V1
  class API < Grape::API
    format :json

    mount Subscriptions
  end
end
