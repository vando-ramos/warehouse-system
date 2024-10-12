require 'rails_helper'

describe 'User registers a supplier' do
  it 'from the suppliers page' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end
    click_on('Register Supplier')

    # assert
    expect(current_path).to eq(new_supplier_path)
    expect(page).to have_content('Register Supplier')
    expect(page).to have_field('Corporate name')
    expect(page).to have_field('Brand name')
    expect(page).to have_field('Registration number')
    expect(page).to have_field('Address')
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    expect(page).to have_field('Email')
    expect(page).to have_button('Create Supplier')
  end

  it 'successfully' do
    # arrange

    # act
    visit(root_path)
    click_on('Suppliers')
    click_on('Register Supplier')
    fill_in 'Corporate name', with: 'Comercial Alimentos S.A.'
    fill_in 'Brand name', with: 'SuperFood'
    fill_in 'Registration number', with: '12.345.678/0001-90'
    fill_in 'Address', with: 'Rua das Palmeiras, 123'
    fill_in 'City', with: 'São Paulo'
    fill_in 'State', with: 'SP'
    fill_in 'Email', with: 'contato@superfood.com.br'
    click_on('Create Supplier')

    # assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Supplier successfully registered!')
    expect(page).to have_content('SuperFood')
    expect(page).to have_content('São Paulo - SP')
  end

  it 'with incomplete data' do
    # arrange

    # act
    visit(root_path)
    click_on('Suppliers')
    click_on('Register Supplier')
    fill_in 'Brand name', with: ''
    fill_in 'Registration number', with: ''
    click_on('Create Supplier')

    # assert
    expect(page).to have_content('Unable to register supplier!')
    expect(page).to have_content("Corporate name can't be blank")
    expect(page).to have_content("Brand name can't be blank")
    expect(page).to have_content("Registration number can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Email can't be blank")
  end
end
