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
end
