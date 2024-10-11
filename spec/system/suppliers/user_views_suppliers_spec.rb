require 'rails_helper'

describe 'User views the suppliers page' do
  it 'from the navbar' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end

    # assert
    expect(current_path).to eq(suppliers_path)
  end

  it 'and sees the registered suppliers' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    visit(root_path)
    click_on('Suppliers')

    # assert
    expect(page).to have_content('Suppliers')
    expect(page).to have_content('SuperFood')
    expect(page).to have_content('São Paulo - SP')
    expect(page).to have_content('TechInd')
    expect(page).to have_content('Curitiba - PR')
  end
end
