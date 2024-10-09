require 'rails_helper'

describe 'User registers a warehouse' do
  it 'from the homepage' do
    # arrange

    # act
    visit(root_path)
    click_on('Register Warehouse')

    # assert
    expect(page).to have_field('Name')
    expect(page).to have_field('Code')
    expect(page).to have_field('City')
    expect(page).to have_field('Area')
    expect(page).to have_field('Address')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Description')
    expect(page).to have_button('Create Warehouse')
  end

  it 'successfully' do
    # arrange

    # act
    visit(root_path)
    click_on('Register Warehouse')
    fill_in 'Name', with: 'Aeroporto SP'
    fill_in 'Code', with: 'GRU'
    fill_in 'City', with: 'Guarulhos'
    fill_in 'Area', with: '13000000'
    fill_in 'Address', with: 'Rodovia Hélio Smidt, s/n - Cumbica'
    fill_in 'CEP', with: '07060-100'
    fill_in 'Description', with: 'Cargas internacionai'
    click_on('Create Warehouse')

    # assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('13000000 m²')
  end
end
