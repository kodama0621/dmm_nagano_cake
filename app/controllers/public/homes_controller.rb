class Public::HomesController < ApplicationController
  def home
  @items = Item.page(params[:page]).reverse_order.per(4)
  end

  def about
  end

end
