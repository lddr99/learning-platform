module Admin
  class Courses < Grape::API
    resource 'courses' do
      desc 'Return courses.'
      get do
        courses = Course.includes(:category, price: :currency).all
        data = Entities::CourseEntity.represent(courses)
        data.as_json
      end

      desc 'Create a course.'
      params do
        requires :title, type: String
        requires :is_available, type: Boolean
        requires :category_id, type: Integer
        requires :duration_of_days, type: Integer
        requires :url, type: String
        requires :price, type: Hash do
          requires :amount, type: String
          requires :currency_id, type: Integer
        end
        optional :description, type: String
      end
      post do
        course = Course.new(
          title: params[:title],
          is_available: params[:is_available],
          category_id: params[:category_id],
          duration_of_days: params[:duration_of_days],
          description: params[:description],
          url: params[:url]
        )

        course.build_price(
          amount: params[:price][:amount],
          currency_id: params[:price][:currency_id]
        )

        course.save

        course
      end

      desc 'Update the course.'
      params do
        optional :title, type: String
        optional :is_available, type: Boolean
        optional :category_id, type: Integer
        optional :duration_of_days, type: Integer
        optional :url, type: String
        optional :price, type: Hash do
          optional :amount, type: String
          optional :currency_id, type: Integer
        end
        optional :description, type: String
      end
      params do
        requires :id, type: Integer, desc: 'Course ID.'
      end
      route_param :id do
        put do
          course = Course.find(params[:id])
          course.update(params.slice(
            :title, :is_available, :duration_of_days, :description, :url, :category_id
          ))

          course.price.update(params[:price]) unless params[:price].nil?
        end
      end

      desc 'Delete the course.'
      params do
        requires :id, type: Integer, desc: 'Course ID.'
      end
      route_param :id do
        delete do
          course = Course.find(params[:id])
          course.destroy
        end
      end
    end
  end
end
