require 'rails_helper'

describe 'User registers a product model' do
  it 'successfully' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
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
    expect(page).to have_content('Product model successfully registered!')
    expect(page).to have_content('Placa Mãe Intel ATX')
    expect(page).to have_content('500g')
    expect(page).to have_content('30cm x 5cm x 20cm')
    expect(page).to have_content('INT-ATX-12345')
    expect(page).to have_content('TechInd')
  end
end
