require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must be a code' do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2024-10-16')

      # act

      # assert
      expect(order.valid?).to be true
    end

    it "expected delivery date can't be blank " do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '')

      # act

      # assert
      expect(order.valid?).to be false
    end

    it "expected delivery date can't be in the past" do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.ago)

      # act
      order.valid?

      # assert
      expect(order.errors.include? :expected_delivery_date).to be true
      expect(order.errors[:expected_delivery_date]).to include('must be in the future')
    end

    it "expected delivery date can't be equal today" do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: Date.today)

      # act
      order.valid?

      # assert
      expect(order.errors.include? :expected_delivery_date).to be true
      expect(order.errors[:expected_delivery_date]).to include('must be in the future')
    end

    it "expected delivery date must be equal to or greater than tomorrow" do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

      # act
      order.valid?

      # assert
      expect(order.errors.include? :expected_delivery_date).to be false
    end

    it "warehouse can't be blank " do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.new(user: user, warehouse: nil, supplier: supplier, expected_delivery_date: '2024-10-16')

      # act
      order.valid?

      # assert
      expect(order.errors.include? :warehouse_id).to be true
    end

    it "supplier can't be blank " do
      # arrange
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      order = Order.new(user: user, warehouse: warehouse, supplier: nil, expected_delivery_date: '2024-10-16')

      # act
      order.valid?

      # assert
      # expect(order.valid?).to be false
      expect(order.errors.include? :supplier_id).to be true
    end
  end

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
