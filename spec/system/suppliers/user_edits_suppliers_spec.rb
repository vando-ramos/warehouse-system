require 'rails_helper'

describe 'User edits a supplier' do
  it 'from the details page' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end
    click_on('TechInd')
    click_on('Edit')

    # assert
    expect(current_path).to eq("/suppliers/#{supplier.id}/edit")
    expect(page).to have_content('Edit TechInd')
    expect(page).to have_field('Corporate Name', with: 'Tecnologia Industrial LTDA')
    expect(page).to have_field('Brand Name', with: 'TechInd')
    expect(page).to have_field('Registration Number', with: '98.765.432/0001-10')
    expect(page).to have_field('Address', with: 'Avenida das Nações, 456')
    expect(page).to have_field('City', with: 'Curitiba')
    expect(page).to have_field('State', with: 'PR')
    expect(page).to have_field('Email', with: 'vendas@techind.com')
  end

  it 'successfully' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    visit(root_path)
    click_on('Suppliers')
    click_on('TechInd')
    click_on('Edit')
    fill_in 'Corporate Name', with: 'Comercial Alimentos S.A.'
    fill_in 'Brand Name', with: 'SuperFood'
    fill_in 'Registration Number', with: '12.345.678/0001-90'
    fill_in 'Address', with: 'Rua das Palmeiras, 123'
    fill_in 'City', with: 'São Paulo'
    fill_in 'State', with: 'SP'
    fill_in 'Email', with: 'contato@superfood.com.br'
    click_on('Update Supplier')

    # assert
    expect(current_path).to eq(supplier_path(supplier.id))
    expect(page).to have_content('Supplier successfully updated')
    expect(page).to have_content('Supplier SuperFood')
    expect(page).to have_content('Comercial Alimentos S.A.')
    expect(page).to have_content('12.345.678/0001-90')
    expect(page).to have_content('Rua das Palmeiras, 123 - São Paulo - SP')
    expect(page).to have_content('contato@superfood.com.br')
  end

  it 'and keeps the required fields' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    # act
    visit(root_path)
    click_on('Suppliers')
    click_on('TechInd')
    click_on('Edit')
    fill_in 'Address', with: ''
    fill_in 'City', with: ''
    fill_in 'State', with: ''
    click_on('Update Supplier')

    # assert
    expect(page).to have_content('Unable to update supplier')
    expect(page).to have_field('Corporate Name', with: 'Tecnologia Industrial LTDA')
    expect(page).to have_field('Brand Name', with: 'TechInd')
    expect(page).to have_field('Registration Number', with: '98.765.432/0001-10')
    expect(page).to have_field('Email', with: 'vendas@techind.com')
  end
end
