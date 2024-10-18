require 'rails_helper'

describe 'User add items to order' do
  it 'successfully' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date)

    product_a = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier)
    product_b = ProductModel.create!(name: 'Product B', weight: 100, width: 30, height: 15, depth: 50, sku: 'PRO-B-456', supplier: supplier)

    # Act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on(order.code)
    click_on('Add Item')
    select 'Product A', from: 'Product Model'
    fill_in 'Quantity', with: '50'
    click_on('Send')

    # Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Item successfully added')
    expect(page).to have_content('Order Items')
    expect(page).to have_content('Product A')
    expect(page).to have_content('20')
  end

  it 'and does not see products from another supplier' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier1 = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                 address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    supplier2 = Supplier.create!(corporate_name: 'Tecnologia LTDA', brand_name: 'Tech', registration_number: '23-456-789/0001-10',
                                 address: 'Avenida das Nações, 1056', city: 'Curitiba', state: 'PR', email: 'contato@tech.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier1, expected_delivery_date: 1.day.from_now.to_date)

    product_a = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier1)
    product_b = ProductModel.create!(name: 'Product B', weight: 100, width: 30, height: 15, depth: 50, sku: 'PRO-B-456', supplier: supplier2)

    # Act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on(order.code)
    click_on('Add Item')

    # Assert
    expect(page).to have_content('Product A')
    expect(page).not_to have_content('Product B')
  end
end
