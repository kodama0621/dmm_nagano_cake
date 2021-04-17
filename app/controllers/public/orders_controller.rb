class Public::OrdersController < ApplicationController
  include ApplicationHelper

  def new
    @order = Order.new
    @addresses = Addresse.where(public: current_customer)
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.addresse_fee = 800
    @order.save

    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_items = @order.order_products.new
      @order_items.item_id = cart_item.item.id
      @order_items.purchase_price = cart_item.item.price
      @order_items.quantity = cart_item.quantity
      @order_items.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_order_complete_path
  end

  def comfirm
    @cart_items = current_customer.cart_items
    total_price = 0
    for cart_item in @cart_items do
      item = cart_item.item
      total_price += (item.price*1.1) * cart_item.quantity
    end
    @total_price = total_price
    @order = current_customer.orders.new(order_params)
    address = params[:address]
    case address
      when 'address' then
        @order.addresse_postal_code = current_customer.postal_code
        @order.addresse_street_adress = current_customer.address
        @order.addresse_name = current_customer.full_name
      when 'addresse_address' then
        addresse = params[:addresse]
        addresse = Addresse.find_by(id: addresse[:addresse_id])
        @order.addresse_postal_code = addresse.postal_code
        @order.addresse_street_adress = addresse.address
        @order.addresse_name = addresse.name
    end
    if @order.valid?
      render "public/orders/comfirm"
    else
      @addresses = Addresse.where(public: current_customer)
      render "public/orders/new"
    end
  end

	def complete
	end

	def index
	  @orders = current_customer.orders
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

  private

  def order_params
    params.require(:order).permit(:addresse_postal_code, :addresse_street_adress, :addresse_name, :method_of_payment)
  end
end
