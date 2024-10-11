require 'rails_helper'

describe 'User deletes a warehouse' do
  it 'successfully' do
    # arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Delete')

    # assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Warehouse successfully deleted!')
    expect(page).not_to have_content('Aeroporto SP')
    expect(page).not_to have_content('Code: GRU')
    expect(page).not_to have_content('City: Guarulhos')
    expect(page).not_to have_content('Area: 13000000 m²')
  end

  it 'and does not delete other warehouses' do
    # arrange
    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                   address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    warehouse2 = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                   cep: '21941-900' , description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Delete')

    # assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Warehouse successfully deleted!')
    expect(page).not_to have_content('Aeroporto SP')
    expect(page).to have_content('Galeão')
  end
end
