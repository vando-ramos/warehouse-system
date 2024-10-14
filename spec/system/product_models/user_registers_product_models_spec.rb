require 'rails_helper'

describe 'User registers a product model' do
  it 'successfully' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    supplier1 = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                 address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    supplier2 = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                 address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Product Models')
    end
    click_on('Register Product Model')
    fill_in 'Name', with: 'Placa Mãe Intel ATX'
    fill_in 'Weight', with: '500'
    fill_in 'Width', with: '30'
    fill_in 'Height', with: '5'
    fill_in 'Depth', with: '20'
    fill_in 'Sku', with: 'INT-ATX-12345'
    select 'TechInd', from: 'Supplier'
    click_on('Create Product model')

    # assert
    expect(current_path).to eq('/product_models/1')
    expect(page).to have_content('Product model successfully registered!')
    expect(page).to have_content('Placa Mãe Intel ATX')
    expect(page).to have_content('500g')
    expect(page).to have_content('30cm x 5cm x 20cm')
    expect(page).to have_content('INT-ATX-12345')
    expect(page).to have_content('TechInd')
  end

  it 'and all fields must be filled in' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')


    # act
    login_as(user)
    visit(root_path)
    click_on('Product Models')
    click_on('Register Product Model')
    fill_in 'Name', with: ''
    fill_in 'Weight', with: ''
    fill_in 'Width', with: ''
    fill_in 'Height', with: ''
    fill_in 'Depth', with: ''
    fill_in 'Sku', with: ''
    select 'TechInd', from: 'Supplier'
    click_on('Create Product model')

    # assert
    expect(page).to have_content('Unable to register product model!')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Weight can't be blank")
    expect(page).to have_content("Width can't be blank")
    expect(page).to have_content("Height can't be blank")
    expect(page).to have_content("Depth can't be blank")
    expect(page).to have_content("Sku can't be blank")
  end
end
