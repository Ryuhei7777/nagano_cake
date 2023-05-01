class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    customer = @customer.update(customer_params)
    redirect_to customers_path
  end

  def withdraw_check
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    customer = @customer.update(is_deleted: true)
  end



  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end
