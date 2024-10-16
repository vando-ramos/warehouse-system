require 'rails_helper'

describe 'User views only their own orders' do
  it 'if authenticated' do
    # Arrange

    # Act
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'and does not see other orders' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    admin = User.create!(name: 'Admin', email: 'admin@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)
    order2 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 2.day.from_now)
    order3 = Order.create!(user: admin, warehouse: warehouse, supplier: supplier, expected_delivery_date: 3.day.from_now)

    # Act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end

    # Assert
    expect(page).to have_content(order1.code)
    expect(page).to have_content(order2.code)
    expect(page).to have_content('User - user@email.com')
    
    expect(page).not_to have_content(order3.code)
    expect(page).not_to have_content('Admin - admin@email.com')
  end
end
