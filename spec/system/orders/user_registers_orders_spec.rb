require 'rails_helper'

describe 'User registers a order' do
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

  it 'successfully' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                      cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                     address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on('Register Order')
    select 'Aeroporto SP - GRU', from: 'Destination Warehouse'
    select supplier.corporate_name, from: 'Supplier'
    fill_in 'Expected Delivery Date', with: '2024-10-20'
    click_on('Create Order')

    # assert
    expect(page).to have_content('Order successfully registered')
    expect(page).to have_content('Order ABCDE12345')
    expect(page).to have_content('User - user@email.com')
    expect(page).to have_content('Aeroporto SP - GRU')
    expect(page).to have_content('Tecnologia Industrial LTDA')
    expect(page).to have_content('2024-10-20')
    expect(page).not_to have_content('Galeão')
    expect(page).not_to have_content('Comercial Alimentos S.A.')
  end

  it "and expected delivery date can't be blank" do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Orders')
    end
    click_on('Register Order')
    select 'Aeroporto SP - GRU', from: 'Destination Warehouse'
    select supplier.corporate_name, from: 'Supplier'
    fill_in 'Expected Delivery Date', with: ''
    click_on('Create Order')

    # assert
    expect(page).to have_content('Unable to register order')
    expect(page).to have_content("Expected Delivery Date can't be blank")
  end
end
