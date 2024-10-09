class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show]

  def show
  end

  def new
    @warehouse = Warehouse.new
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
