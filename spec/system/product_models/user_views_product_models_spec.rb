require 'rails_helper'

describe 'User views the product models page' do
  it 'if authenticated' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Product Models')
    end

    # assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'from the navbar' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    # act
    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Product Models')
    end

    # assert
    expect(current_path).to eq(product_models_path)
  end

  it 'and sees the registered product models' do
    # arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    product_model = ProductModel.create!(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

    product_model = ProductModel.create!(name: 'Memória RAM 16GB DDR4', weight: 200, width: 14, height: 2, depth: 1, sku: 'RAM-DDR4-67890', supplier: supplier)

    # act
    login_as(user)
    visit(root_path)
    click_on('Product Models')

    # assert
    expect(page).to have_content('Product Models')
    expect(page).to have_content('Placa Mãe Intel ATX')
    expect(page).to have_content('INT-ATX-12345')
    expect(page).to have_content('TechInd')
    expect(page).to have_content('Memória RAM 16GB DDR4')
    expect(page).to have_content('RAM-DDR4-67890')
    expect(page).to have_content('TechInd')
  end

  it "and there are no registered product models" do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    # Act
    login_as(user)
    visit(root_path)
    click_on ('Product Models')

    # Assert
    expect(page).to have_content("There are no registered product models!")
  end
end
