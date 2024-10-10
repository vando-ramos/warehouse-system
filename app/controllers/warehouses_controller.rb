class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update]

  def show
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: 'Warehouse successfully registered!'
    else
      flash.now.alert = 'Unable to register warehouse!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to @warehouse, notice: 'Warehouse successfully updated!'
    else
      flash.now.alert = 'Unable to update warehouse!'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
end
