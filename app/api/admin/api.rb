module Admin
  class API < Grape::API
    format :json

    mount CourseEditor
  end
end
