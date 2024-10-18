class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model
  belongs_to :order
end
