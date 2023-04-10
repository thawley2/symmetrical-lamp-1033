class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def customer_count
    customers.size
  end
end