module Admin
  class API < Grape::API
    format :json
    helpers APIHelpers::AuthHelpers

    before do
      authenticate_admin!
    end

    mount Courses
    mount Categories
    mount Currencies
  end
end
