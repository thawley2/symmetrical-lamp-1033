class Supermarket < ApplicationRecord
  has_many :items
  has_many :customers, through: :items

  def all_customers
    customers.distinct.pluck(:name)
  end
end