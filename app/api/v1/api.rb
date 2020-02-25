module V1
  class API < Grape::API
    format :json

    mount V1::Subscriptions
  end
end
