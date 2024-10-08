require 'rails_helper'

describe 'User visit homepage' do
  it "and sees the app's name" do
    # arrange

    # act
    visit('/')

    # assert
    expect(page).to have_content('Warehouses&Stocks')
  end
end
