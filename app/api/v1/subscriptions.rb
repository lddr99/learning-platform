module V1
  class Subscriptions < Grape::API
    helpers V1::Helpers

    resource 'subscriptions' do
      params do
        requires :course_id, type: Integer
      end

      post do
        authenticate!

        course = Course.find_by id: params[:course_id], is_available: true

        error! 'course is not available.', 422 if course.nil?

        today = DateTime.now

        unless current_user.subscription.where(course_id: params[:course_id])
                   .where('"start_at" <= ?', today)
                   .where('"end_at" >= ?', today)
                   .empty?
          error! 'subscription already exists.', 422
        end

        # In the demo, will auto-generate the payment and activate the subscription
        subscription = current_user.subscription.create(
          course_id: params[:course_id],
          start_at: today,
          end_at: today.advance(days: course.duration_of_days)
        )

        subscription.create_payment(
          currency_id: course.price.currency_id,
          amount: course.price.amount
        )

        subscription.as_json
      end
    end
  end
end
