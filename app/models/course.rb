class Course < ApplicationRecord
  has_one :price, dependent: :destroy
  belongs_to :category
end
