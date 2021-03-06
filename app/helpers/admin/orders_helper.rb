module Admin::OrdersHelper
  def tax_price(price)
    (price*1.1).floor
  end

  # 小計の計算
  def sub_price(sub)
    (tax_price(sub.item.price) * sub.amount)
  end

  # 合計金額の計算
  def total_price(totals)
    price = 0
    totals.each do |total|
      price += sub_price(total)
    end
    return price
  end

  # 請求合計金額の計算（注文履歴詳細画面）
  def billing_admin(order)
    total_price(order.order_details) + order.shoping_cost
  end
end
