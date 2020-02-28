class Subscription < ApplicationRecord
  has_one :payment
  belongs_to :course, -> { readonly }

  scope :active, lambda {
    today = DateTime.now
    where('"start_at" <= ?', today)
    where('"end_at" >= ?', today)
  }

  scope :expired, lambda {
    today = DateTime.now
    where('"start_at" > ?', today)
    where('"end_at" < ?', today)
  }
end
