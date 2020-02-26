module V1
  class API < Grape::API
    format :json

    mount User::API => '/users'
    mount Subscriptions
    mount Payments
  end
end
