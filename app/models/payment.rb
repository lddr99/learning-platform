class Payment < ApplicationRecord
  belongs_to :subscription, -> { readonly }
  belongs_to :currency, -> { readonly }
end
