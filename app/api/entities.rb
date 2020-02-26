module Entities
  class CategoryEntity < Grape::Entity
    expose :id
    expose :name
  end

  class CurrencyEntity < Grape::Entity
    expose :id
    expose :name
  end

  class PriceEntity < Grape::Entity
    expose :currency, as: :currency_id do |price|
      price.currency.id
    end

    expose :amount
  end

  class CourseEntity < Grape::Entity
    expose :id
    expose :title
    expose :is_available
    expose :duration_of_days
    expose :title
    expose :description
    expose :url
    expose :category_id, as: :category_id do |course|
      course.category.id
    end

    expose :price, using: PriceEntity
  end

  class SubscriptionEntity < Grape::Entity
    expose :course_id
    expose :start_at
    expose :end_at
  end

  class SubscriptionPaymentEntity < Grape::Entity
    expose :id
    expose :created_at, as: :payment_time
    expose :price do
      expose :amount
      expose :currency, as: :currency_id do |payment|
        payment.currency.name
      end
    end
    expose :subscription, using: SubscriptionEntity
  end
end
