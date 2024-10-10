require 'rails_helper'

describe 'User views the details of a warehouse' do
  it 'and sees additional information' do
    # arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')

    # assert
    expect(page).to have_content('Warehouse GRU')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('13000000 m²')
    expect(page).to have_content('Rodovia Hélio Smidt, s/n - Cumbica - CEP: 07060-100')
    expect(page).to have_content('Cargas internacionais')
  end

  it 'and returns to the homepage' do
    # arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Home')

    # assert
    expect(current_path).to eq(root_path)
  end
end
