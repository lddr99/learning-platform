require 'rails_helper'

describe 'test course resource operations' do
  let(:subscription_api) { '/api/v1/subscriptions' }

  it 'when the user didn\'t login' do
    get subscription_api

    expect(response.status).to eq(401)
  end

  it 'when the user is login' do
    user = create(:user)
    sign_in user

    get subscription_api

    expect(response.status).to eq(200)
  end

  describe 'POST /api/v1/subscriptions' do
    before do
      user = create(:admin_user)
      sign_in user
    end
    it 'create the user subscriptions' do
      course = create(:course)
      params = { course_id: course.id }

      post subscription_api, params: params

      expect(response).to have_http_status :created
    end
  end
  describe 'GET /api/v1/subscriptions' do
    before do
      @user = create(:admin_user)
      sign_in @user
    end
    it 'return user subscriptions' do
      subscription = create(:active_subscription, user_id: @user.id)

      get subscription_api

      response_subscription = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(response_subscription['course_id']).to eq subscription.course_id
    end
    it 'filter active subscriptions' do
      active_subscriptions = create_list(:active_subscription, 2, user_id: @user.id)
      create_list(:expired_subscription, 3, user_id: @user.id)

      get subscription_api, params: { is_active: true }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response.count).to eq active_subscriptions.count
    end
    it 'filter subscriptions by the categories' do
      # subscription[0].course.category_id 1, subscription[1].course.category_id 2 ...
      subscriptions = create_list(:active_subscription, 3, user_id: @user.id)

      test_subscription = subscriptions[2]

      get subscription_api, params: {
        'category_ids[]': test_subscription.course.category_id
      }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response.count).to eq 1
      expect(json_response.first['id'].to_i).to eq test_subscription.id
    end
  end
end
