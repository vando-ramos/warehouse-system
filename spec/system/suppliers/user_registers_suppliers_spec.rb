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
    expect(page).to have_field('Corporate name')
    expect(page).to have_field('Brand name')
    expect(page).to have_field('Registration number')
    expect(page).to have_field('Address')
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    expect(page).to have_field('Email')
    expect(page).to have_button('Create Supplier')
  end
end
