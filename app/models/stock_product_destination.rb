class StockProductDestination < ApplicationRecord
  belongs_to :stock_product

  validates :recipient, :address, presence: true
end
