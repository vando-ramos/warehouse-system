class Api::V1::WarehousesController < Api::V1::ApiController
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

  def create
    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end
end
