class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :code, uniqueness: true

  def warehouse_info
    "#{name} - #{code}"
  end
end
