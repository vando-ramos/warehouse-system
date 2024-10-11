require 'rails_helper'

describe 'User views the product models page' do
  it 'from the navbar' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Product Models')
    end

    # assert
    expect(current_path).to eq(product_models_path)
  end
end
