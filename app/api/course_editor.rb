class CourseEditor < Grape::API
  namespace 'courses' do
    desc 'Return a course.'

    params do
      requires :id, type: Integer, desc: 'Course ID.'
    end

    route_param :id do
      get do
        course = Course.find(params[:id])
        data = Entities::CourseEntity.represent(course)
        data.as_json
      end
    end
  end
end
