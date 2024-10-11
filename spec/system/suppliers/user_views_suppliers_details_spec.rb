require 'rails_helper'

describe 'User views the details of a supplier' do
  it 'and sees additional information' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end
    click_on('SuperFood')

    # assert
    expect(current_path).to eq(supplier_path(supplier.id))
    expect(page).to have_content('SuperFood')
    expect(page).to have_content('Comercial Alimentos S.A.')
    expect(page).to have_content('12.345.678/0001-90')
    expect(page).to have_content('Rua das Palmeiras, 123 - São Paulo - SP')
    expect(page).to have_content('contato@superfood.com.br')
  end
end
