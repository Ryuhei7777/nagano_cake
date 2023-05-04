class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).per(10).order(id: "DESC")
  end
end
