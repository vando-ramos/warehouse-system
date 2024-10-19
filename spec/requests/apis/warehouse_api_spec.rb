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
    end
  end
end
