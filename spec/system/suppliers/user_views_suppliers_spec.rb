require 'rails_helper'

describe 'User views the suppliers page' do
  it 'from the navbar' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Suppliers')
    end

    # assert
    expect(current_path).to eq(suppliers_path)
  end
end
