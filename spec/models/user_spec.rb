require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#user_info' do
    it 'displays name and email' do
      # arrange
      user = User.new(name: 'User', email: 'user@email.com', password: '123456')

      # act
      result  = user.user_info

      # assert
      expect(result).to eq('User - user@email.com')
    end
  end
end
