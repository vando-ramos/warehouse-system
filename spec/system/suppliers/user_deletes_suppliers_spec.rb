require 'rails_helper'

describe 'User deletes a supplier' do
  it 'successfully' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end
    click_on('TechInd')
    click_on('Delete')

    # assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Supplier successfully deleted!')
    expect(page).not_to have_content('TechInd')
    expect(page).not_to have_content('Curitiba - PR')
  end
end
