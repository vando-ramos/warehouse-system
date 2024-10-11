require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when the corporate name is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the brand name is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: '', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the registration number is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the address is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: '', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the city is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: '', state: 'PR', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the state is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: '', email: 'vendas@techind.com')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end

      it 'false when the email is empty' do
        # arrange
        supplier = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: '')

        # act

        # assert
        expect(supplier.valid?).to eq false
      end
    end

    it 'false when the corporate name is already in use' do
      # arrange
      supplier1 = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                   address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

      supplier2 = Supplier.new(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                               address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      # act

      # assert
      expect(supplier2.valid?).to eq false
    end

    it 'false when the registration number is already in use' do
      # arrange
      supplier1 = Supplier.create!(corporate_name: 'Comercial Alimentos S.A.', brand_name: 'SuperFood', registration_number: '12.345.678/0001-90',
                                   address: 'Rua das Palmeiras, 123', city: 'São Paulo', state: 'SP', email: 'contato@superfood.com.br')

      supplier2 = Supplier.new(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '12.345.678/0001-90',
                               address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      # act

      # assert
      expect(supplier2.valid?).to eq false
    end
  end
end
