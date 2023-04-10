class CustomerItemsController < ApplicationController

  def create
    customer = Customer.find(params[:id])
    item = Item.find(params[:item])
    CustomerItem.create!(customer: customer, item: item)
    redirect_to "/customers/#{customer.id}"
  end
end