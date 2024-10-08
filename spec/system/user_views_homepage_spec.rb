require 'rails_helper'

describe 'User visits homepage' do
  it "and sees the app's name" do
    # arrange

    # act
    visit('/')

    # assert
    expect(page).to have_content('Warehouses&Stocks')
  end

  it "and sees the registered warehouses" do
    # arrange
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000)
    Warehouse.create(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000)

    # act
    visit('/')

    # assert
    expect(page).not_to have_content('There are no registered warehouses!')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Code: GRU')
    expect(page).to have_content('City: Guarulhos')
    expect(page).to have_content('Area: 13000000 m²')

    expect(page).to have_content('Galeão')
    expect(page).to have_content('Code: GIG')
    expect(page).to have_content('City: Rio de Janeiro')
    expect(page).to have_content('Area: 18000000 m²')
  end

  it "and there are no registered warehouses" do
    # arrange

    # act
    visit('/')

    # assert
    expect(page).to have_content('There are no registered warehouses!')
  end
end
