require 'rails_helper'

describe 'User edits a warehouse' do
  it 'from the details page' do
    # arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Edit')

    # assert
    expect(page).to have_content('Edit Aeroporto SP')
    expect(page).to have_field('Name', with: 'Aeroporto SP')
    expect(page).to have_field('Code', with: 'GRU')
    expect(page).to have_field('City', with: 'Guarulhos')
    expect(page).to have_field('Area', with: 13000000)
    expect(page).to have_field('Address', with: 'Rodovia Hélio Smidt, s/n - Cumbica')
    expect(page).to have_field('CEP', with: '07060-100')
    expect(page).to have_field('Description', with: 'Cargas internacionais')
  end
end
