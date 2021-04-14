class Admin::OrderItemsController < ApplicationController
  def index
  if params[:id].nil?
   @orders = Order.all.page(params[:page]).per(10)
  else
   @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
  end
 end

 def current_index
  if params[:id].nil?
   @orders = Order.all.page(params[:page]).per(10)
  else
   @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
  end
 end

 def today_order_index
  now = Time.current
  @orders = Order.where(created_at: now.all_day)
  render :index
 end

	def show
	  @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
    total_price = 0
    for cart_item in @order_items do
      item = cart_item.item
      total_price += (item.price*1.1) * cart_item.quantity
    end
    @total_price = total_price
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		redirect_to admins_order_path(@order)
	end

	private
	def order_params
		  params.require(:order).permit(:status)
	end

end
end
