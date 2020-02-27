require 'rails_helper'

describe 'test course resource operations' do
  let(:course_api) { '/api/admin/courses' }

  before do
    user = create(:admin_user)
    sign_in user
  end

  context 'GET /api/admin/courses' do
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
  context 'POST /api/admin/courses' do
    it 'fail for parameter missing' do
      course = build(:course)

      params = {
        title: course.title
      }

      post course_api, params: params

      expect(response).to have_http_status(400)
    end
    it 'create a new course' do
      course = build(:course)
      price = build(:price)

      params = {
        title: course.title,
        is_available: course.is_available,
        duration_of_days: course.duration_of_days,
        description: course.description,
        url: course.url,
        category_id: course.category_id,
        price: {
          amount: price.amount,
          currency_id: price.currency_id
        }
      }

      post course_api, params: params

      expect(response).to have_http_status :created
    end
  end
  context 'PUT /api/admin/courses/{:id}' do
    it 'update the title of course' do
      course = create(:course)
      new_title = "new_#{course.title}"

      params = { title: new_title }

      put "#{course_api}/#{course.id}", params: params

      expect(response).to have_http_status(200)
      expect(Course.find(course.id).title).to eq new_title
    end

    it 'update the price of course' do
      course = create(:course)

      params = {
        price: {
          amount: course.price.amount * 10
        }
      }

      put "#{course_api}/#{course.id}", params: params

      expect(response).to have_http_status(200)
      expect(Course.find(course.id).price.amount).to eq params[:price][:amount]
    end
  end
  context 'Delete /api/admin/courses/{:id}' do
    it 'delete the course' do
      course = create(:course)

      delete "#{course_api}/#{course.id}"

      expect(response).to have_http_status(200)
      expect(Course.exists?(course.id)).to be false
    end
  end
end
