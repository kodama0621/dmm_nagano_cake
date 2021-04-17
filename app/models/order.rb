class Order < ApplicationRecord
  belongs_to :customer
	has_many :order_items, dependent: :destroy
  validates :addresse_postal_code, format: { with: /\A\d{7}\z/ }
  validates :addresse_street_adress, presence: true
  validates :addresse_name, presence: true

  def full_address
    return "〒" + self.addresse_postal_code + " " + self.addresse_street_adress
  end

  def total_payment
    total_price = 0
    self.order_items.each do |item|
      total_price += item.purchase_price * item.quantity
    end
    return self.addresse_fee + total_price
  end

  def  total_count
    total_count = 0
    self.order_items.each do |item|
      total_count += item.quantity
    end
    return total_count
  end

  enum method_of_payment: {クレジットカード: 0, 銀行振込: 1}

  enum status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}

end
