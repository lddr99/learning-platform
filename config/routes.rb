Rails.application.routes.draw do
  get 'management/course-editor', to: 'management#course_editor'

  mount_devise_token_auth_for 'User', at: 'api-auth'
  mount V1::API => '/api/v1'
  mount Admin::API => '/api/admin'
end
