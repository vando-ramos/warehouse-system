class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :address, :city, :state, :email, presence: true
  validates :corporate_name, uniqueness: true
  validates :registration_number, uniqueness: true
end
