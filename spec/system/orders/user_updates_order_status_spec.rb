require 'rails_helper'

describe 'User updates the order status' do
  it 'to delivered' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    product = ProductModel.create!(supplier: supplier, name: 'Caixa de som', weight: '200', width: '20', height: '40', depth: '20', sku: 'CX-SOM-500')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date, status: 'pending')

    OrderItem.create!(product_model: product, order: order, quantity: 50)

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on(order.code)
    click_on('Delivered')

    # assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Delivered')
    expect(page).not_to have_button('Delivered')
    expect(page).not_to have_button('Canceled')
    expect(StockProduct.count).to eq(50)
    stock = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(stock).to eq(50)
  end

  it 'to canceled' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    product = ProductModel.create!(supplier: supplier, name: 'Caixa de som', weight: '200', width: '20', height: '40', depth: '20', sku: 'CX-SOM-500')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date, status: 'pending')

    OrderItem.create!(product_model: product, order: order, quantity: 50)

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on(order.code)
    click_on('Canceled')

    # assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Canceled')
    expect(StockProduct.count).to eq(0)
  end
end
