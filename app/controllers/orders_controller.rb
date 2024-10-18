class OrdersController < ApplicationController
  before_action :set_order_and_check_user, only: %i[show edit update delivered canceled]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
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

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(orders_params)
      redirect_to @order, notice: 'Order successfully updated'
    else
      flash.now.alert = 'Unable to update order'
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    @code = params['query']
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def delivered
    @order.delivered!

    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
      end
    end
    
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def orders_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date, :status)
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])

    if @order.user != current_user
      return redirect_to orders_path, alert: 'You do not have access to this order'
    end
  end
end
