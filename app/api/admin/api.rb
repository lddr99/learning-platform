module Admin
  class API < Grape::API
    format :json
    helpers APIHelpers::AuthHelpers

    before do
      authenticate_admin!
    end

    mount CourseEditor
    mount Categories
    mount Currencies
  end
end
