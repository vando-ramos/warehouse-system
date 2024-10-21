class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = ProductModel.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: t('notices.warehouse.registered')
    else
      flash.now.alert = t('alerts.warehouse.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to @warehouse, notice: t('notices.warehouse.updated')
    else
      flash.now.alert = t('alerts.warehouse.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: t('notices.warehouse.deleted')
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end
end
