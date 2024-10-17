class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :warehouse_id, :supplier_id, :code, :expected_delivery_date, presence: true
  validate :expected_delivery_date_future_validation

  before_validation :generate_code

  enum status: { pending: 0, delivered: 1, canceled: 2 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def expected_delivery_date_future_validation
    if self.expected_delivery_date.present? && self.expected_delivery_date <= Date.today
      self.errors.add(:expected_delivery_date, 'must be in the future')
    end
  end
end
