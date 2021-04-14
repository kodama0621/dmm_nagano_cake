class Public::HomesController < ApplicationController
  def home
  @products = Product.page(params[:page]).reverse_order.per(4)
  end

  def about
  end

end
