require 'rails_helper'

describe 'User searches for orders' do
  it 'from the navbar' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    # act
    login_as(user)
    visit(root_path)

    # Assert
    within('nav') do
      expect(page).to have_field('Search Order')
      expect(page).to have_button('Search')
    end
  end

  it 'if authenticated' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    within('nav') do
      expect(page).not_to have_field('Search Order')
      expect(page).not_to have_button('Search')
    end
  end

  it 'and find a order' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000, address: 'Rodovia Hélio Smidt, s/n - Cumbica',
                                  cep: '07060-100' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      fill_in 'Search Order', with: order.code
      click_on('Search')
    end

    # Assert
    expect(page).to have_content("Search results for #{order.code}")
    expect(page).to have_content('1 order found')
    expect(page).to have_content("#{order.code}")
    expect(page).to have_content('User - user@email.com')
    expect(page).to have_content('Aeroporto SP - GRU')
    expect(page).to have_content('Tecnologia Industrial LTDA')
    # expect(page).to have_content("#{1.day.from_now}")
  end
end
