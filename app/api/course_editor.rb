class CourseEditor < Grape::API
  namespace 'courses' do
    desc 'Return all courses.'

    get do
      courses = Course.includes(price: :currency).all
      data = Entities::CourseEntity.represent(courses)
      data.as_json
    end
  end
end
