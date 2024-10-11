class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show edit update]

  def index
    @suppliers = Supplier.all
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to suppliers_path, notice: 'Supplier successfully registered!'
    else
      flash.now.alert = 'Unable to register supplier!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: 'Supplier successfully updated!'
    else
      flash.now.alert = 'Unable to update supplier!'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :address, :city, :state, :email)
  end
end
