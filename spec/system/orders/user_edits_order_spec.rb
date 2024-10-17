require 'rails_helper'

describe 'User edits an order' do
  it 'if authenticated' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date)

    # act
    visit(edit_order_path(order.id))

    # assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000, address: 'Rodovia Hélio Smidt, s/n - Cumbica',
                                  cep: '07060-100' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    supplier = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date)

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on(order.code)
    click_on('Edit')
    select 'Aeroporto SP', from: 'Destination Warehouse'
    select 'Comercial Alimentos S.A.', from: 'Supplier'
    fill_in 'Expected Delivery Date', with: 1.week.from_now.to_date
    click_on('Update Order')

    # assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Order successfully updated')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Comercial Alimentos S.A.')
    expect(page).to have_content(1.week.from_now.to_date)
  end

  it 'and only their own orders' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')
    admin = User.create!(name: 'Admin', email: 'admin@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: admin, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date)

    # Act
    login_as(user)
    visit(order_path(order.id))

    # Assert
    expect(current_path).not_to eq(edit_order_path(order.id))
    expect(current_path).to eq(orders_path)
    expect(page).to have_content('You do not have access to this order')
  end
end
