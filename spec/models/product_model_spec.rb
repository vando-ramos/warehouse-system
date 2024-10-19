require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it "name can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: '', weight: 500, width: 30, height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "weight can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: '', width: 30, height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "width can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: 500, width: '', height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "height can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: '', depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "depth can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: 5, depth: '', sku: 'INT-ATX-12345', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "SKU can't be blank" do
      # arrange
      supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                  address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: 5, depth: 20, sku: '', supplier: supplier)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end

    it "supplier can't be blank" do
      # arrange
      product_model = ProductModel.new(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: nil)

      # act

      # assert
      expect(product_model.valid?).to eq false
    end
  end

  it 'false when the sku is already in use' do
    # arrange
    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    product_model1 = ProductModel.create!(name: 'Placa Mãe Intel ATX', weight: 500, width: 30, height: 5, depth: 20, sku: 'INT-ATX-12345', supplier: supplier)

    product_model2 = ProductModel.new(name: 'Memória RAM 16GB DDR4', weight: 200, width: 14, height: 2, depth: 1, sku: 'INT-ATX-12345', supplier: supplier)

    # act

    # assert
    expect(product_model2.valid?).to eq false
  end
end
