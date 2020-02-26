require 'rails_helper'

describe 'test the APIs for course editor', type: :request do
  context 'admin permissions guard' do
    it 'when the user didn\'t login' do
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

  context 'courses resource' do
    before do
      user = create(:admin_user)
      sign_in user
    end

    it 'return course entities' do
      course = create(:course)

      get '/api/admin/courses'

      json_response = JSON.parse(response.body).first

      expect(json_response['title']).to eq(course.title)
      expect(json_response['is_available']).to eq(course.is_available)
      expect(json_response['duration_of_days']).to eq(course.duration_of_days)
      expect(json_response['description']).to eq(course.description)
      expect(json_response['url']).to eq(course.url)

      expect(json_response['category_id']).to eq(course.category_id)

      expect(json_response['price']['amount']).to eq(course.price.amount.to_s)
      expect(json_response['price']['currency_id']).to eq(course.price.currency_id)
    end
  end
end
