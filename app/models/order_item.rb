class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :product_model_id, :quantity, presence: true
end
