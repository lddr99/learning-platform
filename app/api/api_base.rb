class APIBase < Grape::API
  prefix 'api'
  format :json

  mount CourseEditor
end
