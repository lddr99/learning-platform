class CourseEditor < Grape::API
  resource 'courses' do
    desc 'Return all courses.'
    get do
      courses = Course.includes(:category, price: :currency).all
      data = Entities::CourseEntity.represent(courses)
      data.as_json
    end

    desc 'Create a course.'
    post do
      course = Course.new({
        title: params[:title],
        is_available: params[:is_available],
        category_id: params[:category_id],
        duration_of_days: params[:duration_of_days],
        description: params[:description],
        url: params[:url]
      })

      course.build_price({
        amount: params[:price][:amount],
        currency_id: params[:price][:currency_id]
      })

      course.save

      course
    end

    desc 'Update a course.'
    params do
      requires :id, type: Integer, desc: 'Course ID.'
    end
    route_param :id do
      put do
        course = Course.find(params[:id])
        course.update(
          title: params[:title],
          is_available: params[:is_available],
          category_id: params[:category_id],
          duration_of_days: params[:duration_of_days],
          description: params[:description],
          url: params[:url]
        )

        course.price.update(
          amount: params[:price][:amount],
          currency_id: params[:price][:currency_id]
        )
      end
    end

    desc 'Delete a course.'
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

  resource 'categories' do
    get do
      categories = Category.all
      data = Entities::CategoryEntity.represent(categories)
      data.as_json
    end
  end

  resource 'currencies' do
    get do
      currencies = Currency.all
      data = Entities::CurrencyEntity.represent(currencies)
      data.as_json
    end
  end
end
