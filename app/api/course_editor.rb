class CourseEditor < Grape::API
  resource 'courses' do
    desc 'Return all courses.'

    get do
      courses = Course.includes(price: :currency).all
      data = Entities::CourseEntity.represent(courses)
      data.as_json
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
