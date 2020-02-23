Rails.application.routes.draw do
  mount APIBase => '/'

  get 'management/course-editor'
end
