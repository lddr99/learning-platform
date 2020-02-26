require 'rails_helper'

describe 'test the APIs for course editor', type: :request do
  context 'admin permissions guard' do
    it 'when the user didn\'t log in' do
      get '/api/admin/courses'

      expect(response.status).to eq(401)
    end

    it 'when the user does not have admin permission' do
      user = create(:user)
      sign_in user
      get '/api/admin/courses'

      expect(response.status).to eq(403)
    end

    it 'when the user has admin permission' do
      user = create(:admin_user)
      sign_in user
      get '/api/admin/courses'

      expect(response.status).to eq(200)
    end
  end
end
