class Api::V1::WarehousesController < ActionController::API
  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses
  end

  def show
    warehouse = Warehouse.find_by(id: params[:id])

    if warehouse.nil?
      return render status: 404
    else
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    end
  end
end
