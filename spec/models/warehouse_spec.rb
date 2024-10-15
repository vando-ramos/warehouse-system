require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when the name is empty' do
        # arrange
        warehouse = Warehouse.new(name: '', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the code is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: '', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the city is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: '', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the area is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: '',
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the address is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: '', cep: '07060-100', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the cep is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '', description: 'Cargas internacionais')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end

      it 'false when the description is empty' do
        # arrange
        warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                  address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: '')

        # act

        # assert
        expect(warehouse.valid?).to eq false
      end
    end

    it 'false when the code is already in use' do
      # arrange
      warehouse1 = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000, address: 'Rodovia Hélio Smidt, s/n - Cumbica',
                                    cep: '07060-100' , description: 'Cargas internacionais')

      warehouse2 = Warehouse.new(name: 'Galeão', code: 'GRU', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                 cep: '21941-900' , description: 'Cargas internacionais')

      # act

      # assert
      expect(warehouse2.valid?).to eq false
    end
  end

  describe '#warehouse_info' do
    it 'displays name and code' do
      # arrange
      warehouse = Warehouse.new(name: 'CDD Guarulhos', code: 'GRU', city: 'Guarulhos', area: 13_000_000,
                                address: 'Rodovia Hélio Smidt, s/n - Cumbica', cep: '07060-100', description: 'Cargas internacionais')

      # act
      result  = warehouse.warehouse_info

      # assert
      expect(result).to eq('CDD Guarulhos - GRU')
    end
  end
end
