class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :authenticate_user!, only: %i[index show new create]

  def index
    @orders = current_user.orders
  end

  def show
    if @order.user != current_user
      redirect_to orders_path, alert: 'You do not have access to this order'
    end
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
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  private

  def orders_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
