class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).reverse_order.per(9)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
