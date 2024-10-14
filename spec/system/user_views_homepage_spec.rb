require 'rails_helper'

describe 'User visits homepage' do
  it "and sees the app's name" do
    # arrange

    # act
    visit(root_path)

    # assert
    expect(page).to have_content('Warehouses & Stocks')
  end

  it "and sees the registered warehouses" do
    # arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000, address: 'Rodovia Hélio Smidt, s/n - Cumbica',
                      cep: '07060-100' , description: 'Cargas internacionais')

    Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                      cep: '21941-900' , description: 'Cargas internacionais')

    # act
    visit(root_path)

    # assert
    expect(page).not_to have_content('There are no registered warehouses!')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('13000000 m²')

    expect(page).to have_content('Galeão')
    expect(page).to have_content('GIG')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('18000000 m²')
  end

  it "and there are no registered warehouses" do
    # arrange

    # act
    visit(root_path)

    # assert
    expect(page).to have_content('There are no registered warehouses!')
  end
end
