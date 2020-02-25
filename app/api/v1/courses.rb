module V1
  class Courses < Grape::API
    helpers APIHelpers::AuthHelpers

    before do
      authenticate!
    end

    resource 'courses' do
      get do
        course_ids = current_user.subscription.pluck('course_id').uniq!
        courses = Course.includes(:category, price: :currency)
                        .where(id: course_ids)

        Entities::CourseEntity.represent(courses)
      end
    end
  end
end
