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

  it 'successfully' do
    # arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

    # act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Edit')
    fill_in 'Name', with: 'Viracopos'
    fill_in 'Code', with: 'VCP'
    fill_in 'City', with: 'Campinas'
    fill_in 'Area', with: 3600000
    fill_in 'Address', with: 'Rodovia Santos Dumont, km 66'
    fill_in 'CEP', with: '13052-000'
    fill_in 'Description', with: 'Cargas nacionais'
    click_on ('Update Warehouse')

    # assert
    expect(current_path).to eq(warehouse_path(warehouse.id))
    expect(page).to have_content('Warehouse successfully updated!')
    expect(page).to have_content('Viracopos')
    expect(page).to have_content('VCP')
    expect(page).to have_content('Campinas')
    expect(page).to have_content('3600000 m²')
    expect(page).to have_content('Rodovia Santos Dumont, km 66 - CEP: 13052-000')
    expect(page).to have_content('Cargas nacionais')
  end
end
