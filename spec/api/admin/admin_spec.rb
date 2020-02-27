require 'rails_helper'

describe 'test admin permissions guard' do
  let(:course_api) { '/api/admin/courses' }
  it 'when the user didn\'t login' do
    get course_api

    expect(response.status).to eq(401)
  end

  it 'when the user does not have admin permission' do
    user = create(:user)
    sign_in user
    get course_api

    expect(response.status).to eq(403)
  end

  it 'when the user has admin permission' do
    user = create(:admin_user)
    sign_in user
    get course_api

    expect(response.status).to eq(200)
  end
end
