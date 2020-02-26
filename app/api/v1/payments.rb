module V1
  class Payments < Grape::API
    helpers APIHelpers::AuthHelpers

    before do
      authenticate!
    end

    desc 'Return the user payments.'
    resource 'payments' do
      params do
        requires :course_id, type: Integer
      end

      get do
        subscriptions = current_user.subscription.where course_id: params['course_id']
        subscription_ids = subscriptions.pluck('id')

        payments = Payment.includes(:currency, subscription: :course)
                          .where(subscription_id: subscription_ids)

        Entities::SubscriptionPaymentEntity.represent(payments)
      end
    end
  end
end
