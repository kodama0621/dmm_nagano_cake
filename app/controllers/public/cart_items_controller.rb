class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    total_price = 0
    for cart_item in @cart_items do
      item = cart_item.item
      total_price += (item.price*1.1) * cart_item.quantity
    end
    @total_price = total_price
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
    if @cart_item.nil?
      @cart_item = current_customer.cart_items.new(cart_item_params)
    else
      @cart_item.quantity += params[:quantity].to_i
    end
    if @cart_item.save
      redirect_to public_cart_items_path
    else
      @item = Item.find_by(id: @cart_item.item_id)
      render 'public/items/show'
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    if@cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    else
      @cart_items = current_customer.cart_items
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end



  private
  def cart_item_params
  params.require(:cart_item).permit(:quantity, :product_id, :customer_id)
  end
end
