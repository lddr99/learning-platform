module Admin
  class API < Grape::API
    format :json

    mount Admin::CourseEditor
  end
end
