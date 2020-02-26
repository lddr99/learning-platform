module V1
  module User
    class Courses < Grape::API
      helpers APIHelpers::AuthHelpers

      helpers do
        def request_other_user!
          unless current_user.id == params['id']
            error!('Insufficient privilege to perform the requested operation.', 401)
          end
        end
      end

      before do
        authenticate!
      end

      params do
        optional :is_available, type: Boolean
        optional :category_ids, type: Array
      end

      resource '/courses' do
        get do
          request_other_user!

          course_ids = current_user.subscription.pluck('course_id').uniq!
          courses = Course.includes(:category, price: :currency)
                          .where(id: course_ids)

          unless params['category_ids'].nil?
            courses = courses.where(category_id: params['category_ids'])
          end

          unless params['is_available'].nil?
            courses = courses.where(is_available: params['is_available'])
          end

          Entities::CourseEntity.represent(courses)
        end
      end
    end
  end
end
