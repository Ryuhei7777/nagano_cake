class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    @car_titem = CartItem.new(cart_item_params)
    @car_titem.customer_id = current_customer.id
    @car_titem.save
    redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end