module V1
  class Courses < Grape::API
    helpers APIHelpers::AuthHelpers

    before do
      authenticate!
    end

    params do
      optional :category_ids, type: Array
    end

    resource 'courses' do
      get do
        course_ids = current_user.subscription.pluck('course_id').uniq!
        courses = Course.includes(:category, price: :currency)
                        .where(id: course_ids)

        unless params['category_ids'].nil?
          courses = courses.where(category_id: params['category_ids'])
        end

        Entities::CourseEntity.represent(courses)
      end
    end
  end
end
