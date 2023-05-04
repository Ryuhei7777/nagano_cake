class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @total_cost = 0
    @order.carriage = 800
    if params[:order][:select_address] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.first_name + current_customer.last_name
    else params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    end
    @cart_items = CartItem.all
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.purchase_price = cart_item.item.with_tax_price
      @order_detail.quantity = cart_item.amount
      @order_detail.crafting_status = 0
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_orders_thanks_path
  end

  def thanks
  end

  def index
    @orders = Order.all.order(id: "DESC")
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :shipping_name, :carriage, :billing_amount, :payment_method, :status)
  end
end