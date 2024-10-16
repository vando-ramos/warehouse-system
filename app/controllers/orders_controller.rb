class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :authenticate_user!, only: %i[new create]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(orders_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Order successfully registered'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now.alert = 'Unable to register order'
      render :new, status: :unprocessable_entity
    end
  end

  def search
    @code = params['query']
    @order = Order.find_by(code: @code)
  end

  private

  def orders_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
