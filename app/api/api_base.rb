class APIBase < Grape::API
  prefix 'api'
  format :json

  mount V1::CourseEditor
end
