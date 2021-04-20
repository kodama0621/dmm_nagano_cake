class Item < ApplicationRecord
  belongs_to :genre
	has_many :cart_items
	has_many :orders, through: :order_items
	has_many :order_items

	attachment :image

	validates :is_active, inclusion: { in: [true, false] }
	validates :name, presence: true
	validates :introduction, presence: true
	validates :price, numericality: { only_integer: true, greater_than: 0 }

end
