class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :customer_id, :item_id, :quantity, presence: true
end
