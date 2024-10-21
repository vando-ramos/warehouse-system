class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def new
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      redirect_to @order, notice: t('notices.order_item.added')
    else
      @product_models = @order.supplier.product_models
      
      flash.now.alert = t('alerts.order_item.add_fail')
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
