class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def new
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    if @order.order_items.create(order_item_params)
      redirect_to @order, notice: 'Item successfully added'
    else
      flash.now.alert = 'Unable to add order item'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end
end
