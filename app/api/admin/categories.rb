module Admin
  class Categories < Grape::API
    desc 'Return categories.'
    resource 'categories' do
      get do
        categories = Category.all
        Entities::CategoryEntity.represent(categories)
      end
    end
  end
end
