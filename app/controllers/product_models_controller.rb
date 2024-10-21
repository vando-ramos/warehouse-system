class ProductModelsController < ApplicationController
  before_action :set_product_model, only: %i[show]
  before_action :authenticate_user!, only: %i[index]

  def index
    @product_models = ProductModel.all
  end

  def show
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: t('notices.product_model.registered')
    else
      @suppliers = Supplier.all
      flash.now.alert = t('alerts.product_model.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end
