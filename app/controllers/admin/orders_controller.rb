class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total_cost = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_details.update_all(crafting_status: 1)
    end
    redirect_to admin_order_path(@order)
  end

   def order_params
    params.require(:order).permit(:status)
  end

end
