require 'rails_helper'

describe 'User edits an order' do
  it 'that belongs to another user' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')
    admin = User.create!(name: 'Admin', email: 'admin@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Galeão', code: 'GIG', city: 'Rio de Janeiro', area: 18_000_000, address: 'Av. Jornalista Roberto Marinho, s/n',
                                  cep: '21941-900' , description: 'Cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Tecnologia Industrial LTDA', brand_name: 'TechInd', registration_number: '98.765.432/0001-10',
                                address: 'Avenida das Nações, 456', city: 'Curitiba', state: 'PR', email: 'vendas@techind.com')

    order = Order.create!(user: admin, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now.to_date)

    # Act
    login_as(user)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    # Assert
    expect(response).to redirect_to(orders_path)
  end
end
