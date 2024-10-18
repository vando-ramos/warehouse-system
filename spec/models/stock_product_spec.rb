require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'generates a serial number' do
    it 'when a product enters the stock' do
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now, status: 'delivered')

      product = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier)


      stock_product = StockProduct.create!(warehouse: warehouse, product_model: product, order: order)


      expect(stock_product.serial_number.length).to eq(20)
    end

    it 'and the code must not be modified' do
      user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                    address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      warehouse2 = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                     cep: '21941-900' , description: 'Cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now, status: 'delivered')

      product = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier)

      stock_product = StockProduct.create!(warehouse: warehouse, product_model: product, order: order)

      original_serial_number = stock_product.serial_number


      stock_product.update!(warehouse: warehouse2)


      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end
