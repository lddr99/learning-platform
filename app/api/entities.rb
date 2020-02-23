module Entities
  class CurrencyEntity < Grape::Entity
    expose :id
    expose :name
  end

  class SimpleCurrencyEntity < Grape::Entity
    expose :name, as: :currency
  end

  class PriceEntity < Grape::Entity
    expose :currency, merge: true, using: SimpleCurrencyEntity
    expose :price
  end

  class CourseEntity < Grape::Entity
    expose :id
    expose :title
    expose :is_available
    expose :duration_of_days
    expose :title
    expose :description
    expose :url
    expose :price, using: PriceEntity
  end
end
