class Subscription < ApplicationRecord
  has_one :payment
  belongs_to :course, -> { readonly }
end
