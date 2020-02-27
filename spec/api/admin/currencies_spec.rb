require 'rails_helper'

describe 'GET /api/admin/currencies' do
  before do
    user = create(:admin_user)
    sign_in user
  end

  it 'return currencies' do
    currencies = create_list(:currency, 10)

    get '/api/admin/currencies'

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body).count).to eq currencies.count
  end
end
