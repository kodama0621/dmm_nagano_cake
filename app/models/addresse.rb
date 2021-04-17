class Addresse < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true

  belongs_to :customer
end
