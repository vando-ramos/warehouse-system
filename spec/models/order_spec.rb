require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'generates a random code' do
    it 'when creating a new order' do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2024-10-16')

      # act
      order.save!
      result = order.code

      # assert
      expect(result).not_to be_empty
      expect(result.length).to eq(10)
    end

    it 'and the code must be unique' do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2024-10-16')
      order2 = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2024-10-19')

      # act
      order2.save!

      # assert
      expect(order2.code).not_to eq(order1.code)
    end
  end
end
