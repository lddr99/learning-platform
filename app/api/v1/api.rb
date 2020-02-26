module V1
  class API < Grape::API
    format :json

    mount Subscriptions
    mount Courses
    mount Payments
  end
end
