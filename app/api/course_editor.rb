class CourseEditor < Grape::API
  namespace 'courses' do
    desc 'Return a course.'

    params do
      requires :id, type: Integer, desc: 'Course ID.'
    end

    route_param :id do
      get do
        Course.find(params[:id])
      end
    end
  end
end
