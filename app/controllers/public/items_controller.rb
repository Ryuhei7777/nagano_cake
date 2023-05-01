class Public::ItemsController < ApplicationController
  def index
    @items= Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @items_new = CartItem.new
  end
end
