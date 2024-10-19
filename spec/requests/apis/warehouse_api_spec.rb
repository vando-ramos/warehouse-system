require 'rails_helper'

describe 'Warehouse API', type: :request do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                    cep: '21941-900' , description: 'Cargas internacionais')


      get "/api/v1/warehouses/#{warehouse.id}"


      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Galeão')
      expect(json_response['code']).to eq('GIG')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'fail if warehouse not found' do
      get "/api/v1/warehouses/999999"

      expect(response.status).to eq(404)
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'success' do
      Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 13_000_000, address: 'Rodovia Hélio Smidt, s/n - Cumbica',
                        cep: '07060-100' , description: 'Cargas internacionais')

      Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                        cep: '21941-900' , description: 'Cargas internacionais')


      get '/api/v1/warehouses'


      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response[0]['name']).to eq('Aeroporto SP')
      expect(json_response[1]['name']).to eq('Galeão')
    end

    it 'return empty if there is no warehouse' do
      get '/api/v1/warehouses'


      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end
