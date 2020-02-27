require 'rails_helper'

describe 'GET /api/admin/categories' do
  before do
    user = create(:admin_user)
    sign_in user
  end

  it 'return categories' do
    categories = create_list(:category, 10)

    get '/api/admin/categories'

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body).count).to eq categories.count
  end
end
