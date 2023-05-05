class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    if @order_detail.crafting_status == "in_production"
      @order.update(status: 2)
    end
    
    @order.order_details.each do |order_detail|
      if order_detail.crafting_status == "production_complete"
        @order.update(status: 3)
      else 
        @order.update(status: 2)
      end
    end
    redirect_to admin_order_path(@order)
  end

  def order_detail_params
    params.require(:order_detail).permit(:crafting_status)
  end
  
end
