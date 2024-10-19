require 'rails_helper'

describe 'User views the stock' do
  it "on a warehouse's page" do
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                 address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.week.from_now.to_date)

    product_a = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier)
    product_b = ProductModel.create!(name: 'Product B', weight: 100, width: 30, height: 15, depth: 50, sku: 'PRO-B-456', supplier: supplier)
    product_c = ProductModel.create!(name: 'Product C', weight: 150, width: 50, height: 50, depth: 30, sku: 'PRO-C-789', supplier: supplier)

    20.times { StockProduct.create!(warehouse: warehouse, product_model: product_a, order: order) }
    30.times { StockProduct.create!(warehouse: warehouse, product_model: product_b, order: order) }


    login_as(user)
    visit(root_path)
    click_on('Galeão')


    expect(page).to have_content('Stock Products')
    expect(page).to have_selector('table thead tr th', text: 'Name')
    expect(page).to have_selector('table thead tr th', text: 'SKU')
    expect(page).to have_selector('table thead tr th', text: 'Quantity')

    expect(page).to have_selector('table tbody tr td', text: 'Product A')
    expect(page).to have_selector('table tbody tr td', text: 'PRO-A-123')
    expect(page).to have_selector('table tbody tr td', text: '20')

    expect(page).to have_selector('table tbody tr td', text: 'Product B')
    expect(page).to have_selector('table tbody tr td', text: 'PRO-B-456')
    expect(page).to have_selector('table tbody tr td', text: '30')

    expect(page).not_to have_content('Product C')
    expect(page).not_to have_content('PRO-C-789')
  end

  it 'and remove an item from inventory' do
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                 address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.week.from_now.to_date)

    product = ProductModel.create!(name: 'Product A', weight: 50, width: 15, height: 5, depth: 10, sku: 'PRO-A-123', supplier: supplier)

    20.times { StockProduct.create!(warehouse: warehouse, product_model: product, order: order) }


    login_as(user)
    visit(root_path)
    click_on('Galeão')
    select 'PRO-A-123', from: 'Stock Deduct'
    fill_in 'Destination', with: 'Hilton'
    fill_in 'Destination Address', with: 'Av Atlantica, 500 - Copacabana - Rio de Janeiro - RJ'
    click_on('Confirm Dispatch')


    expect(current_path).to eq(warehouse_path(warehouse.id))
    expect(page).to have_content('Item successfully removed')
    expect(page).to have_content('PRO-A-123')
    expect(page).to have_content('19')
  end
end
