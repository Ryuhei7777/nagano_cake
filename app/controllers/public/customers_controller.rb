class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
  end

  def withdraw_check
  end

  def withdraw
  end
end
